Message-ID: <38B64309.80D4D15B@mpifr-bonn.mpg.de>
Date: Fri, 25 Feb 2000 09:53:29 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: PCMCIA on PowerBook G3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried to get the PCMCIA stuff running on a PowerBook G3/333 (Lombard) with
Linux 2.2.14 and 2.2.15, both from the pmac-stable tree.  Using pcmcia-cs-3.0.14
plus a patch I found in the mailing list, I get kernel freezes each time I
insert a cardbus card.  With vanilla pcmcia-cs-3.1.11, the system doesn't
recognise the card correctly, e.g. (from /var/log/messages):

cardmgr[284]: initializing socket 0
cardmgr[284]: unsupported card in socket 0
kernel: cs: cb_alloc(bus 1): vendor 0xffff, device 0xffff
kernel: cs: no valid ROM images found!
cardmgr[284]:   no product info available

If I type lspci -vv, I also get messages like

01:00.0 Class ffff: Illegal Vendor ID: Unknown device ffff (rev ff) (prog-if ff)
        !!! Unknown header type 7f

Maybe some parts of the bridge were not initialized correctly?  Any ideas?

Thanks for your help, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
