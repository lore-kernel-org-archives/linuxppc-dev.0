Message-ID: <A1C99F4731CAD111BA5400A024FC3B0CBE0414@ESBILMA01EDCGE>
From: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Formatting JFFS2 Flash
Date: Wed, 13 Mar 2002 10:50:29 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

	I have a PPC 860T custom board with kernel
2.4.4-2001-11-11-denx and rtai-24.1.4-2-denx. I have
a JFFS2 filesystem on 14MB Flash. I make an initial
filesystem with the "mkfs.jffs2" utility, and the first time
I copy a 1MB file into it, it takes about 2 minutes, and
then on it takes 10 seconds to copy into it the same file.
I suppose that the first time, jffs2 is doing something like
"formatting" the flash.
Does anybody out there know how to do this "formatting"
in a smarter way?

				Thank you
					Billa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
