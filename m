Message-ID: <39F5FFCE.6C94AAEC@mvista.com>
Date: Tue, 24 Oct 2000 14:31:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root filesystem over nfs
References: <2F67A63DFFB1D31185D90090278CBB2D017D2A39@apmail6.chn.agilent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"ZHANG,HAI-TAO (Non-A-China,ex1)" wrote:

> Hi,
>
> I tried to change one line in eepro100.c and now the 2.4.0-test9 boot is ok.
>
> $ diff eepro100.c eepro100.c.orig
> 1098c1098
> <       outl(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE),
> ---
> >       outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE)),
>
> It seems like the endianess is changed twice so the kernel hangs up. Maybe
> we should define some macros like outl for CONFIG_SANDPOINT.
>
> Thanks,
> Haitao Zhang

Hmmm, I thought I had this change in the latest sanpoint source that I put on
the ftp server.  In fact, I thought there was a discussion on this in this
mailing list a few weeks ago.  Anyway, sounds like its fixed now...

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
