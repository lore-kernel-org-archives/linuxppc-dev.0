MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Formatting JFFS2 Flash
Date: Wed, 13 Mar 2002 10:14:04 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096AA2@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You should try the linux-mtd mailing lists.

http://lists.infradead.org/mailman/listinfo/linux-mtd/

Navin.

-----Original Message-----
From: Billalabeitia, Jose Carlos (IndSys, GEPM)
[mailto:jc.billalabeitia@indsys.ge.com]
Sent: Wednesday, March 13, 2002 9:50 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Formatting JFFS2 Flash



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
