Message-ID: <38B646F6.DFB8D167@pop.agri.ch>
Date: Fri, 25 Feb 2000 10:10:14 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCMCIA on PowerBook G3
References: <38B64309.80D4D15B@mpifr-bonn.mpg.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Albrecht Dreﬂ wrote:
>
> I tried to get the PCMCIA stuff running on a PowerBook G3/333 (Lombard) with
> Linux 2.2.14 and 2.2.15, both from the pmac-stable tree.  Using pcmcia-cs-3.0.14
> plus a patch I found in the mailing list, I get kernel freezes each time I
> insert a cardbus card.  With vanilla pcmcia-cs-3.1.11, the system doesn't
> recognise the card correctly, e.g. (from /var/log/messages):
>
> cardmgr[284]: initializing socket 0
> cardmgr[284]: unsupported card in socket 0
> kernel: cs: cb_alloc(bus 1): vendor 0xffff, device 0xffff
> kernel: cs: no valid ROM images found!
> cardmgr[284]:   no product info available
>
> If I type lspci -vv, I also get messages like
>
> 01:00.0 Class ffff: Illegal Vendor ID: Unknown device ffff (rev ff) (prog-if ff)
>         !!! Unknown header type 7f
>
> Maybe some parts of the bridge were not initialized correctly?  Any ideas?
>
> Thanks for your help, Albrecht.

As you've sent in an earlier message you're aware of the CardBus patch.
When you apply this patch to your kernel then the CardBus is detected.
BUT as far as my experiences goes, you must have inserted the CardBus
card before boot.

I have a ethernet/modem from Xircom working.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
