Date: Fri, 10 Sep 1999 11:47:22 +0200
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: New quik and iMac OF
Message-Id: <19990910114722.029413@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've seen the new quik 2.0 posted on linuxppc.org and tried it on an
iMac. I used the "second" file (ELF image of secondary bootloader), put
it on an HFS partition, and used the command

boot hd:5,second

(5 is the partition number of the HFS partition)

It works. However, quik itself won't do anything useful since I didn't
setup the boot device correctly (and I didn't have a kernel to boot from
anyway).

So basically, it should be possible to make bootable CDs with an HFS
partition, a boot-info file with the type "tbxi" containing the above
command and the "second" bootstrap. I don't know yet if we can also add a
"first.b"/"second.b" version on the same CD for old machines, or if they
can also do the above trick (they may be able using Apple's System Disk
control panel which contains the appropriate OF patches).



-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
