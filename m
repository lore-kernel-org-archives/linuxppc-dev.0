Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCE90@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Disk On Chip: Can't build ntfl_format
Date: Mon, 30 Jul 2001 04:27:55 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've tried to build ntfl_format for my PPC860 needed to 'un-hose' the MTD Disk
On Chip.
But it fails.

bash# gcc nftl_format.c
/tmp/cca000931.o: In function `check_block':
/tmp/cca000931.o(.text+0xd4): undefined reference to `pread'
/tmp/cca000931.o(.text+0x140): undefined reference to `pwrite'
/tmp/cca000931.o(.text+0x170): undefined reference to `pread'
/tmp/cca000931.o(.text+0x24c): undefined reference to `pwrite'
/tmp/cca000931.o(.text+0x27c): undefined reference to `pread'
/tmp/cca000931.o(.text+0x358): undefined reference to `pwrite'
/tmp/cca000931.o(.text+0x388): undefined reference to `pread'
/tmp/cca000931.o: In function `main':
/tmp/cca000931.o(.text+0xa58): undefined reference to `pwrite'
/tmp/cca000931.o(.text+0xae8): undefined reference to `pwrite'
/tmp/cca000931.o(.text+0xb40): undefined reference to `pwrite'
/tmp/cca000931.o(.text+0xbd0): undefined reference to `pwrite'
collect2: ld returned 1 exit status


Has anyone an idea?

best regards
Martin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
