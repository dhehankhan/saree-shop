create table sarees (
  id bigint generated always as identity primary key,
  title text not null,
  description text,
  image_url text not null,
  video_url text not null,
  sort int default 0,
  created_at timestamptz default now()
);
alter table sarees enable row level security;
create policy "all read" on sarees for select using (true);
create policy "admin write" on sarees for all to authenticated using (true) with check (true);

insert into storage.buckets (id, name, public) values ('media','media',true);
create policy "media read" on storage.objects for select using (bucket_id='media');
create policy "media write" on storage.objects for insert to authenticated with check (bucket_id='media');
create policy "media delete" on storage.objects for delete to authenticated using (bucket_id='media');

create table settings (key text primary key, value text);
alter table settings enable row level security;
create policy "settings read" on settings for select using (true);
create policy "settings write" on settings for all to authenticated using (true) with check (true);
insert into settings values ('shop_name','আমার শাড়ি ঘর'),('whatsapp','01754007716');
