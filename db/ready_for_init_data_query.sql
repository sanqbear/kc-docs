-- INIT Role Data
--- role related to user management
insert into organizations.roles (name, description)
values 
(
  'ticket_viewer',
  '{"en-US": "Can view tickets", "ko-KR": "티켓을 볼 수 있음", "ja-JP": "チケットを表示できます", "zh-CN": "可以查看工单"}'
);
insert into organizations.roles (name, description)
values
(
  'ticket_editor',
  '{"en-US": "Can create and edit tickets", "ko-KR": "티켓을 생성 및 편집할 수 있음", "ja-JP": "チケットを作成および編集できます", "zh-CN": "可以创建和编辑工单"}'
);
insert into organizations.roles (name, description)
values
(
  'ticket_manager',
  '{"en-US": "Can manage tickets", "ko-KR": "티켓을 관리할 수 있음", "ja-JP": "チケットを管理できます", "zh-CN": "可以管理工单"}'
);
insert into organizations.roles (name, description)
values
(
  'full_access',
  '{"en-US": "System Administrator with full access", "ko-KR": "전체 액세스 권한이 있는 시스템 관리자", "ja-JP": "フルアクセス権を持つシステム管理者", "zh-CN": "具有完全访问权限的系统管理员"}'
);

--- init public group
insert into organizations.groups (public_id, name, description)
values
(
    'public',
    '{"en-US": "Public", "ko-KR": "공개", "ja-JP": "パブリック", "zh-CN": "公开"}',
    '{"en-US": "Default public group for all users", "ko-KR": "모든 사용자를 위한 기본 공개 그룹", "ja-JP": "すべてのユーザーのためのデフォルトのパブリックグループ", "zh-CN": "所有用户的默认公共组"}'
);

--- assign roles to public group
insert into organizations.group_roles (group_id, role_id)
select g.id, r.id
from organizations.groups g, organizations.roles r
where g.public_id = 'public'
  and r.name = 'ticket_editor';

--- init sysadmin group
insert into organizations.groups (public_id, name, description)
values
(
    'sysadmin',
    '{"en-US": "System Administrators", "ko-KR": "시스템 관리자", "ja-JP": "システム管理者", "zh-CN": "系统管理员"}',
    '{"en-US": "Group for system administrators with full access", "ko-KR": "전체 액세스 권한이 있는 시스템 관리자 그룹", "ja-JP": "フルアクセス権を持つシステム管理者のグループ", "zh-CN": "具有完全访问权限的系统管理员组"}'
);
--- assign all roles to sysadmin group
insert into organizations.group_roles (group_id, role_id)
select g.id, r.id
from organizations.groups g, organizations.roles r
where g.public_id = 'sysadmin';



  -- 이미지 전용 스토리지 (10MB 제한)
  INSERT INTO managements.file_storages (
      name,
      storage_type,
      base_path,
      config,
      status,
      max_file_size,
      allowed_mime_types,
      is_default
  ) VALUES (
      'local-images',
      'LOCAL',
      './uploads/images',
      '{"permissions": "0755"}'::jsonb,
      'ACTIVE',
      10485760,  -- 10MB
      ARRAY['image/jpeg', 'image/png', 'image/gif', 'image/webp'],
      false
  );

  -- 문서 전용 스토리지 (50MB 제한)
  INSERT INTO managements.file_storages (
      name,
      storage_type,
      base_path,
      config,
      status,
      max_file_size,
      allowed_mime_types,
      is_default
  ) VALUES (
      'local-documents',
      'LOCAL',
      './uploads/documents',
      '{"permissions": "0755"}'::jsonb,
      'ACTIVE',
      52428800,  -- 50MB
      ARRAY['application/pdf', 'application/msword',
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
   'text/plain'],
      false
  );

  확인 쿼리

  -- 등록된 스토리지 확인
  SELECT
      public_id,
      name,
      storage_type,
      base_path,
      status,
      pg_size_pretty(max_file_size::bigint) as max_size,
      allowed_mime_types,
      is_default
  FROM managements.file_storages
  WHERE is_deleted = false;

