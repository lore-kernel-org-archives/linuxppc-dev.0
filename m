Message-ID: <39BE6B91.7ECA07D@mvista.com>
Date: Tue, 12 Sep 2000 10:44:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
CC: Alex Shnitman <alexsh@hectic.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint & random crashes?
References: <2F67A63DFFB1D31185D90090278CBB2D014ECFEF@apmail6.chn.agilent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This isn't a total surprise.  I've had problems with this version of the
kernel.  Most seem to be timing problems.  I managed to get things stable on
the processor/host-bridge combo's that I use--I just ran some test on a 755/107
overnight and its still working fine.  Evidently, and not surprisingly, your
timings are different.

Probably the real fix is to get the latest ppc tree stable, then move the
sandpoint stuff forward to that.

Mark
--

"ZHANG,HAI-TAO (Non-A-China,ex1)" wrote:

> Hi,
>
> I am using the 603e + 107 sandpoint board, and use the nfsroot from
> MontaVista CDK1.2. I have boot the kernel succesfully with the 2.3.16 kernel
> from MontaVista Area51, added the IDE part for your 2.4 version, it is ok
> for NFS boot. So I am not sure what is the difference between those two
> versions, and I guess that there are some errors in 2.4 which crash the
> kernel.
>
> Thanks,
> Haitao,
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
