Date: Thu, 25 Nov 1999 16:35:27 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: yaboot 0.2
Message-Id: <19991125163527.021520@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've posted version 0.2 of yaboot, it adds network booting (the config
file, the kernel and the ramdisk can be retreived via TFTP, and with the
appropriate bootp server settings, the machine will completely network
boot when booting with the "N" key).

still to do:

 - fix and merge the head.S MMU patch in the kernel (yaboot will require
this patch)
 - include Stephen Edie ISO filesystem and test with CD-ROMs
 - graphical UI
 - merge with quik (hum... can this simply replace quik ? I would have to
add code to handle broken OF claim)
 - add a README file and example config file, write man pages, etc...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
