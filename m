Date: Wed, 28 Jan 2004 00:36:22 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] simple fix
Message-Id: <20040128003622.4c0a7917.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Small patch against linuxppc-2.5-benh rsync tree pulled half hour ago (GMT+1).


--- fs/hfs/extent.c_old Wed Jan 28 00:31:30 2004
+++ fs/hfs/extent.c     Wed Jan 28 00:31:56 2004
@@ -470,8 +470,8 @@
        if (inode->i_size > HFS_I(inode)->phys_size) {
                struct address_space *mapping = inode->i_mapping;
                struct page *page;
-               size = inode->i_size - 1;
                int res;
+               size = inode->i_size - 1;

                page = grab_cache_page(mapping, size >> PAGE_CACHE_SHIFT);
                if (!page)



--
Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
