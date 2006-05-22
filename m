Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 2C0EE67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 01:30:57 +1000 (EST)
Subject: Re: SCC1 as serial console
From: Jeff Angielski <jeff@theptrgroup.com>
To: Ladislav =?iso-8859-2?Q?Klenovi=E8?= <lk99336@pobox.sk>
In-Reply-To: <e65a39032a7d4cdbbf87ecc1daa271cd@pobox.sk>
References: <e65a39032a7d4cdbbf87ecc1daa271cd@pobox.sk>
Content-Type: text/plain; charset=utf-8
Date: Mon, 22 May 2006 11:27:54 -0400
Message-Id: <1148311675.8422.18.camel@sumo-jaa.nrl.navy.mil>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-22 at 15:33 +0200, Ladislav Klenovič wrote:
> Hi,
> can anybody help me to setup the SCC1 port as serial console on MPC860 
> with kernel 2.6.15.4? I would like to use it as system console during 
> the booting proccess. I can not get any output on serial console during 
> booting proccess, I use uboot.

What are your kernel command line arguments?  Are you passing the right
ones in?

Have you configured the SCC correctly in the kernel?  Chosen SCC1? Baud
rates correct?  etc.  

Does your hardware need any special tweaks to the SCC code that is in
u-boot but not your kernel?


Jeff Angielski
The PTR Group
