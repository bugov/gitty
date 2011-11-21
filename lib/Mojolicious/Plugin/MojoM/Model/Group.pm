package Mojolicious::Plugin::MojoM::Model::Group;
use base 'Mojolicious::Plugin::MojoM::Base';

=head1 MySQL

    create table `group`
    (
        `id`        int(11) unsigned not null auto_increment primary key,
        `name`      varchar(64) character set utf8 collate utf8_general_ci not null,
        `desc`      varchar(1024) character set utf8 collate utf8_general_ci not null,
        `prioritet` int(11) unsigned not null default 0
    );

=cut

    __PACKAGE__->meta->setup
    (
        table      => 'group',
        
        columns    =>
        [
            id           => { type => 'serial' , not_null => 1 },
            name         => { type => 'varchar', not_null => 1, length => 64 },
            desc         => { type => 'varchar', not_null => 1, length => 1024 },
            prioritet    => { type => 'integer', not_null => 1, length => 11, default => 0 },
        ],
        
        pk_columns => 'id',
        
        unique_key => 'name',
        
        relationships =>
        [
            users =>
            {
                type      => 'many to many',
                map_class => 'Mojolicious::Plugin::MojoM::Model::UserToGroup',
            }
        ],
    );

# Manager

package Mojolicious::Plugin::MojoM::Model::Group::Manager;
use base 'Rose::DB::Object::Manager';

    sub object_class { 'Mojolicious::Plugin::MojoM::Model::Group' }

    __PACKAGE__->make_manager_methods( 'group' );

1;

__END__

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011, Georgy Bazhukov.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
