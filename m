Date: Tue, 14 Sep 1999 15:11:30 +0200
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au,
        eek@escape.ca
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: New booter (d2)
Message-Id: <19990914151130.001641@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I updated the online archive. The source code is basically the same, but
I added a couple of missing resources which prevented it from booting at
all (I inadvertently removed them while making the previous archive). I
also fixed the enclosed disk image, you should be able to use it with
Apple's DiskCopy program to make a bootable floppy. Just add the
vmlinux.gz file. (Don't forget to use -vf9 when compressing the file).

http://calvaweb.calvacom.fr/bh40/test.html

If you want to test with something else than a floppy, you have to copy
the content of resource 'boot' ID 1 to block 0 and 1 of the HFS volume
(boot blocks). 

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
