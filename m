To: "dony" <dony.he@huawei.com>
Cc: "Wolfgang Denk" <wd@denx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which board use 8260 CPU? 
In-reply-to: Your message of "Mon, 26 Feb 2001 19:40:08 +0800"
             <000901c09fe8$def06760$8021690a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Feb 2001 02:10:30 +1100
Message-ID: <24937.983200230@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 26 Feb 2001 19:40:08 +0800, "dony" <dony.he@huawei.com> writes:
>   Since my custom board use 8260, I want to find a board  using 8260 from ppc
>boot/board as a example.  I know "cogent"  board supports 8260, but it seems t
>o be a little complex for me.

You are correct - the Cogent platform is a modular system - different
motherboard and cpu module combinations, and the motherboards have
varying I/O capabilities (serial, flash, ethernet, pci, video, ...)
as do the cpu modules - I like the platform a lot, but the ppcboot port
is probably unnecessarily complicated for most other platforms.

>Are there other boards using  8260 CPU which can meet the following requiremen
>ts:
> 1  Initialize CPU core registers , SDRAM, MMU,SIU, CPM
> 2  Initialize Serial Port and Network (SMC , FCC).
>3  Download kernel from tftp server or load kernel from on-board flash ?

Use the "hymod" port as a starting point - but it's probably best to
create your own port.

BTW, this question probably should have been asked on the ppcboot-users
mailing list on lists.sourceforge.net - this list is for Linux/PPC
embedded systems questions. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
