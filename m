Message-ID: <39D0D4EC.44A255DB@mvista.com>
Date: Tue, 26 Sep 2000 09:55:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anybody get 2.4 successful with sandpoint?
References: <2F67A63DFFB1D31185D90090278CBB2D01679E37@apmail6.chn.agilent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There is a sandpoint port to 2.4.0-test2 by MontaVista sitting at
ftp://www.mvista.com/pub/Area51/sandpoint-8240/sandpoint.linux.tar.gz

It can be built from with the 8240 tools from the MontaVista 1.2 CDK.  It
works on an 8240 and a 755/107 combo but there are some outstanding problems
too that I have not yet had time to look at.  Take a look, it may save you
some time.

I plan to bring it up to the latest kernel and push it up to the bitkeeper
repos when my schedule permits.

Mark
--

"ZHANG,HAI-TAO (Non-A-China,ex1)" wrote:

> Hi,
>
> Has anybody got successful boot of 2.4 kernel with sandpoint board? I am
> using sandpoint 603e with lastest 2.4-test-9, but it still gets hang up
> while executing /sbin/init.
>
> Thanks,
> Haitao Zhang
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
