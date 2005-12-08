Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 12BF5688BC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 17:00:35 +1100 (EST)
Received: from White64 (p54B4A731.dip0.t-ipconnect.de [84.180.167.49])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id jB861BR06223
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Dec 2005 07:01:24 +0100
Date: Thu, 8 Dec 2005 06:59:07 +0100
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051208065907.26c2b1d0@White64>
In-Reply-To: <20051207172321.77464.qmail@web53515.mail.yahoo.com>
References: <20051205203941.GA16695@mail.gnudd.com>
	<20051207172321.77464.qmail@web53515.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: Video Card to Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Wed, 7 Dec 2005 09:23:21 -0800 (PST) schrieb roger blofeld
<blofeldus@yahoo.com> :

> What is the status of the mpc5200 support? I see Sylvain's repository
> is still at 2.6.12 (5 months old).
> 
> http://gitbits.246tnt.com/gitweb.cgi?p=linux-2.6-mpc52xx.git;a=summary
> 
> The current kernel.org kernel doesn't appear to support fec/DMA. Is
> there a plan to get networking support into the mainstream kernel?
> 
> Thanks
> -rb
> 


i think Sylvians should be update in some days. I hope.
you can pull his rep. without problems on current 2.6.15-rc4.

DMA is a problem, because the implementation from Freescale use binary
data, and has some dirty points. This would never be included in the
mainstream kernel. Sylvian has included the new DMA .. works fine for
FEC.

If someone get this new implementtion running with AC97 or PCI would be
fine.
