Date: 7 Sep 2002 10:07:46 -0000
Message-ID: <20020907100746.2950.qmail@mailweb34.rediffmail.com>
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Ramdisk and load_elf_binary problem....
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anybody have a hint towards my problem.?

on using Ramdisk

1. I get original and computed both CRC and legth o.k
2. Ramdisk uncompression goes fine..
3.filesysten ext2_fs mount also goes fine.

but when I try to exec any programme say "/bin/sh"
in do_execve() it calls load_elf_binary
  , there it checks for,

if(elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
goto out;

in my case e_type always comes 0x200 that is not expected anway
and it fails there.

also earlier when i try to open "/dev/ttS0" it reports
error 2 that is "no such file found"

since i amn't subscribed to list pls. cc to me.

Thanks...
Atul

__________________________________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
