-- INIT Role Data
--- role related to user management
insert into organizations.roles (name, description)
values
  (
    'USER.READ.MY', 
    '{"ko-KR": "내 사용자 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read my user information.", 
     "ja-JP": "自分のユーザー情報を読み取る権限です。", 
     "zh-CN": "有权读取我的用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER.UPDATE.MY', 
    '{"ko-KR": "내 사용자 정보를 수정할 수 있는 권한입니다.", 
     "en-US": "Permission to update my user information.", 
     "ja-JP": "自分のユーザー情報を更新する権限です。", 
     "zh-CN": "有权更新我的用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER.READ.ALL', 
    '{"ko-KR": "모든 사용자 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all user information.", 
     "ja-JP": "すべてのユーザー情報を読み取る権限です。", 
     "zh-CN": "有权读取所有用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER.UPDATE.ALL', 
    '{"ko-KR": "모든 사용자 정보를 수정할 수 있는 권한입니다.", 
     "en-US": "Permission to update all user information.", 
     "ja-JP": "すべてのユーザー情報を更新する権限です。", 
     "zh-CN": "有权更新所有用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER.CREATE.ALL', 
    '{"ko-KR": "사용자 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create user information.", 
     "ja-JP": "ユーザー情報を作成する権限です。", 
     "zh-CN": "有权创建用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER.DELETE.ALL', 
    '{"ko-KR": "사용자 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete user information.", 
     "ja-JP": "ユーザー情報を削除する権限です。", 
     "zh-CN": "有权删除用户信息。"}'
  );
--- role related to group management
insert into organizations.roles (name, description)
values
  (
    'GROUP.READ.MY', 
    '{"ko-KR": "내 그룹 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read my group information.", 
     "ja-JP": "自分のグループ情報を読み取る権限です。", 
     "zh-CN": "有权读取我的组信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP.READ.ALL', 
    '{"ko-KR": "모든 그룹 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all group information.", 
     "ja-JP": "すべてのグループ情報を読み取る権限です。", 
     "zh-CN": "有权读取所有组信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP.CREATE.ALL', 
    '{"ko-KR": "모든 그룹 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create all group information.", 
     "ja-JP": "すべてのグループ情報を作成する権限です。", 
     "zh-CN": "有权创建所有组信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP.UPDATE.ALL', 
    '{"ko-KR": "모든 그룹 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all group information.", 
        "ja-JP": "すべてのグループ情報を更新する権限です。", 
        "zh-CN": "有权更新所有组信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP.DELETE.ALL', 
    '{"ko-KR": "모든 그룹 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all group information.", 
     "ja-JP": "すべてのグループ情報を削除する権限です。", 
     "zh-CN": "有权删除所有组信息。"}'
  );
--- role related to role management
insert into organizations.roles (name, description)
values
  (
    'ROLE.READ.ALL', 
    '{"ko-KR": "모든 역할 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all role information.", 
     "ja-JP": "すべての役割情報を読み取る権限です。", 
     "zh-CN": "有权读取所有角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'ROLE.CREATE.ALL', 
    '{"ko-KR": "모든 역할 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create all role information.", 
     "ja-JP": "すべての役割情報を作成する権限です。", 
     "zh-CN": "有权创建所有角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'ROLE.UPDATE.ALL', 
    '{"ko-KR": "모든 역할 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all role information.", 
        "ja-JP": "すべての役割情報を更新する権限です。", 
        "zh-CN": "有权更新所有角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'ROLE.DELETE.ALL', 
    '{"ko-KR": "모든 역할 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all role information.", 
     "ja-JP": "すべての役割情報を削除する権限です。", 
     "zh-CN": "有权删除所有角色信息。"}'
  );
--- role related to group users management
insert into organizations.roles (name, description)
values
  (
    'GROUP_USERS.READ.MY', 
    '{"ko-KR": "내 그룹 사용자 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read my group user information.", 
     "ja-JP": "自分のグループユーザー情報を読み取る権限です。", 
     "zh-CN": "有权读取我的组用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_USERS.READ.ALL', 
    '{"ko-KR": "모든 그룹 사용자 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all group user information.", 
     "ja-JP": "すべてのグループユーザー情報を読み取る権限です。", 
     "zh-CN": "有权读取所有组用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_USERS.CREATE.ALL', 
    '{"ko-KR": "모든 그룹 사용자 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create all group user information.", 
     "ja-JP": "すべてのグループユーザー情報を作成する権限です。", 
     "zh-CN": "有权创建所有组用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_USERS.UPDATE.ALL', 
    '{"ko-KR": "모든 그룹 사용자 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all group user information.", 
        "ja-JP": "すべてのグループユーザー情報を更新する権限です。", 
        "zh-CN": "有权更新所有组用户信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_USERS.DELETE.ALL', 
    '{"ko-KR": "모든 그룹 사용자 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all group user information.", 
     "ja-JP": "すべてのグループユーザー情報を削除する権限です。", 
     "zh-CN": "有权删除所有组用户信息。"}'
  );
--- role related to group roles management
insert into organizations.roles (name, description)
values
  (
    'GROUP_ROLES.READ.ALL', 
    '{"ko-KR": "모든 그룹 역할 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all group role information.", 
     "ja-JP": "すべてのグループ役割情報を読み取る権限です。", 
     "zh-CN": "有权读取所有组角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_ROLES.CREATE.ALL', 
    '{"ko-KR": "모든 그룹 역할 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create all group role information.", 
     "ja-JP": "すべてのグループ役割情報を作成する権限です。", 
     "zh-CN": "有权创建所有组角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_ROLES.UPDATE.ALL', 
    '{"ko-KR": "모든 그룹 역할 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all group role information.", 
        "ja-JP": "すべてのグループ役割情報を更新する権限です。", 
        "zh-CN": "有权更新所有组角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'GROUP_ROLES.DELETE.ALL', 
    '{"ko-KR": "모든 그룹 역할 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all group role information.", 
     "ja-JP": "すべてのグループ役割情報を削除する権限です。", 
     "zh-CN": "有权删除所有组角色信息。"}'
  );

-- role related to user roles management
insert into organizations.roles (name, description)
values
  (
    'USER_ROLES.READ.ALL', 
    '{"ko-KR": "모든 사용자 역할 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all user role information.", 
     "ja-JP": "すべてのユーザー役割情報を読み取る権限です。", 
     "zh-CN": "有权读取所有用户角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER_ROLES.CREATE.ALL', 
    '{"ko-KR": "모든 사용자 역할 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create all user role information.", 
     "ja-JP": "すべてのユーザー役割情報を作成する権限です。", 
     "zh-CN": "有权创建所有用户角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER_ROLES.UPDATE.ALL', 
    '{"ko-KR": "모든 사용자 역할 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all user role information.", 
        "ja-JP": "すべてのユーザー役割情報を更新する権限です。", 
        "zh-CN": "有权更新所有用户角色信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'USER_ROLES.DELETE.ALL', 
    '{"ko-KR": "모든 사용자 역할 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all user role information.", 
     "ja-JP": "すべてのユーザー役割情報を削除する権限です。", 
     "zh-CN": "有权删除所有用户角色信息。"}'
  );

--- role related ticket management
insert into organizations.roles (name, description)
values
  (
    'TICKETS.READ.MY', 
    '{"ko-KR": "내 티켓 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read my ticket information.", 
     "ja-JP": "自分のチケット情報を読み取る権限です。", 
     "zh-CN": "有权读取我的票据信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKETS.CREATE.ALL', 
    '{"ko-KR": "모든 티켓 정보를 생성할 수 있는 권한입니다.", 
     "en-US": "Permission to create all ticket information.", 
     "ja-JP": "すべてのチケット情報を作成する権限です。", 
     "zh-CN": "有权创建所有票据信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKETS.UPDATE.MY', 
    '{"ko-KR": "내 티켓 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update my ticket information.", 
        "ja-JP": "自分のチケット情報を更新する権限です。", 
        "zh-CN": "有权更新我的票据信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKETS.DELETE.MY', 
    '{"ko-KR": "내 티켓 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete my ticket information.", 
     "ja-JP": "自分のチケット情報を削除する権限です。", 
     "zh-CN": "有权删除我的票据信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKETS.READ.ALL', 
    '{"ko-KR": "모든 티켓 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all ticket information.", 
     "ja-JP": "すべてのチケット情報を読み取る権限です。", 
     "zh-CN": "有权读取所有票据信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKETS.UPDATE.ALL', 
    '{"ko-KR": "모든 티켓 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all ticket information.", 
        "ja-JP": "すべてのチケット情報を更新する権限です。", 
        "zh-CN": "有权更新所有票据信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKETS.DELETE.ALL', 
    '{"ko-KR": "모든 티켓 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all ticket information.", 
     "ja-JP": "すべてのチケット情報を削除する権限です。", 
     "zh-CN": "有权删除所有票据信息。"}'
  );
--- role related ticket entries management
insert into organizations.roles (name, description)
values
  (
    'TICKET_ENTRIES.READ.ALL', 
    '{"ko-KR": "모든 티켓 항목 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all ticket entry information.", 
     "ja-JP": "すべてのチケット項目情報を読み取る権限です。", 
     "zh-CN": "有权读取所有票据条目信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKET_ENTRIES.CREATE.ALL', 
    '{"ko-KR": "모든 티켓 항목 정보를 생성할 수 있는 권한입니다.",
        "en-US": "Permission to create all ticket entry information.", 
        "ja-JP": "すべてのチケット項目情報を作成する権限です。", 
        "zh-CN": "有权创建所有票据条目信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKET_ENTRIES.UPDATE.MY', 
    '{"ko-KR": "내 티켓 항목 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update my ticket entry information.", 
        "ja-JP": "自分のチケット項目情報を更新する権限です。", 
        "zh-CN": "有权更新我的票据条目信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKET_ENTRIES.DELETE.MY', 
    '{"ko-KR": "내 티켓 항목 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete my ticket entry information.", 
     "ja-JP": "自分のチケット項目情報を削除する権限です。", 
     "zh-CN": "有权删除我的票据条目信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKET_ENTRIES.UPDATE.ALL', 
    '{"ko-KR": "모든 티켓 항목 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all ticket entry information.", 
        "ja-JP": "すべてのチケット項目情報を更新する権限です。", 
        "zh-CN": "有权更新所有票据条目信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TICKET_ENTRIES.DELETE.ALL', 
    '{"ko-KR": "모든 티켓 항목 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all ticket entry information.", 
     "ja-JP": "すべてのチケット項目情報を削除する権限です。", 
     "zh-CN": "有权删除所有票据条目信息。"}'
  );
--- role related tags management
insert into organizations.roles (name, description)
values
  (
    'TAGS.READ.ALL', 
    '{"ko-KR": "모든 태그 정보를 조회할 수 있는 권한입니다.", 
     "en-US": "Permission to read all tag information.", 
     "ja-JP": "すべてのタグ情報を読み取る権限です。", 
     "zh-CN": "有权读取所有标签信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TAGS.CREATE.ALL', 
    '{"ko-KR": "모든 태그 정보를 생성할 수 있는 권한입니다.",
        "en-US": "Permission to create all tag information.", 
        "ja-JP": "すべてのタグ情報を作成する権限です。", 
        "zh-CN": "有权创建所有标签信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TAGS.UPDATE.ALL', 
    '{"ko-KR": "모든 태그 정보를 수정할 수 있는 권한입니다.",
        "en-US": "Permission to update all tag information.", 
        "ja-JP": "すべてのタグ情報を更新する権限です。", 
        "zh-CN": "有权更新所有标签信息。"}'
  );

insert into organizations.roles (name, description)
values
  (
    'TAGS.DELETE.ALL', 
    '{"ko-KR": "모든 태그 정보를 삭제할 수 있는 권한입니다.", 
     "en-US": "Permission to delete all tag information.", 
     "ja-JP": "すべてのタグ情報を削除する権限です。", 
     "zh-CN": "有权删除所有标签信息。"}'
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
insert into organizations.group_roles (group_id, role_id, assigned_by)
select
    g.id,
    r.id,
    null
from
    organizations.groups g,
    organizations.roles r
where
    g.public_id = 'public'
    and r.name in (
        'USER.READ.MY',
        'GROUP.READ.MY',
        'TICKETS.READ.MY',
        'TICKETS.CREATE.ALL',
        'TICKETS.UPDATE.MY',
        'TICKETS.DELETE.MY',
        'TICKET_ENTRIES.READ.ALL',
        'TICKET_ENTRIES.CREATE.ALL',
        'TICKET_ENTRIES.UPDATE.MY',
        'TICKET_ENTRIES.DELETE.MY',
        'TAGS.READ.ALL',
        'TAGS.CREATE.ALL',
        'TAGS.UPDATE.ALL',
        'TAGS.DELETE.ALL'     
    );

--- init sysadmin group
insert into organizations.groups (public_id, name, description)
values
(
    'sysadmin',
    '{"en-US": "System Administrators", "ko-KR": "시스템 관리자", "ja-JP": "システム管理者", "zh-CN": "系统管理员"}',
    '{"en-US": "Group for system administrators with full access", "ko-KR": "전체 액세스 권한이 있는 시스템 관리자 그룹", "ja-JP": "フルアクセス権を持つシステム管理者のグループ", "zh-CN": "具有完全访问权限的系统管理员组"}'
);
--- assign all roles to sysadmin group
insert into organizations.group_roles (group_id, role_id, assigned_by)
select
    g.id,
    r.id,
    null
from
    organizations.groups g,
    organizations.roles r
where
    g.public_id = 'sysadmin';
    