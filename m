Message-ID: <20030212181536.8600.qmail@web41215.mail.yahoo.com>
Date: Wed, 12 Feb 2003 10:15:36 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: sash source code Compilation
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <BAY2-F15mkH4WOkA32x0002431b@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I have compiled sash source code in denx environment.
Following is the compilation log. Do you see any
problem with the compilation?

I added the resulting sash elf to ramdisk, still after
exeve'ing from init/main.c, i don;t see any output.

-------------
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o sash.o sash.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmds.o cmds.c
In file included from cmds.c:19:
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:47:
warning: `BLOCK_SIZE' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:28:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:101:
warning: `MS_RDONLY' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:37:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:102:
warning: `MS_NOSUID' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:39:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:103:
warning: `MS_NODEV' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:41:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:104:
warning: `MS_NOEXEC' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:43:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:105:
warning: `MS_SYNCHRONOUS' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:45:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:106:
warning: `MS_REMOUNT' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:47:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:107:
warning: `MS_MANDLOCK' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:49:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:108:
warning: `MS_NOATIME' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:57:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:109:
warning: `MS_NODIRATIME' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:59:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:110:
warning: `MS_BIND' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:61:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:121:
warning: `MS_RMT_MASK' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:65:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:126:
warning: `MS_MGC_VAL' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:70:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:134:
warning: `S_APPEND' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:53:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:135:
warning: `S_IMMUTABLE' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:55:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:170:
warning: `BLKROSET' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:78:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:171:
warning: `BLKROGET' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:79:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:172:
warning: `BLKRRPART' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:80:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:173:
warning: `BLKGETSIZE' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:81:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:174:
warning: `BLKFLSBUF' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:82:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:175:
warning: `BLKRASET' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:83:
warning: this is the location of the previous
definition
/opt/eldk/usr/../ppc_4xx/usr/include/linux/fs.h:176:
warning: `BLKRAGET' redefined
/opt/eldk/usr/../ppc_4xx/usr/include/sys/mount.h:84:
warning: this is the location of the previous
definition
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_dd.o cmd_dd.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_ed.o cmd_ed.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_grep.o cmd_grep.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_ls.o cmd_ls.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_tar.o cmd_tar.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_gzip.o cmd_gzip.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_find.o cmd_find.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_file.o cmd_file.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_chattr.o cmd_chattr.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o cmd_ar.o cmd_ar.c
ppc_4xx-gcc -O3 -Wall -Wmissing-prototypes -DHAVE_EXT2
  -c -o utils.o utils.c
ppc_4xx-gcc -static -s -o sash sash.o cmds.o cmd_dd.o
cmd_ed.o cmd_grep.o cmd_ls.o cmd_tar.o cmd_gzip.o
cmd_find.o cmd_file.o cmd_chattr.o cmd_ar.o utils.o
-L/opt/eldk/ppc_4xx/usr/lib
-------------

Thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
