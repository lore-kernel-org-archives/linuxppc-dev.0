Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id DC3D367A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 08:27:23 +1100 (EST)
Date: Wed, 23 Feb 2005 14:27:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
Message-ID: <20050223142720.C13087@cox.net>
References: <421CD2B3.4020805@ybb.ne.jp> <421CD669.1040002@ybb.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421CD669.1040002@ybb.ne.jp>;
	from takeharu1219@ybb.ne.jp on Thu, Feb 24, 2005 at 04:15:53AM
	+0900
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 04:15:53AM +0900, Takeharu KATO wrote:
> Hi
> 
> Sorry, I sent the mail before checking it by mistake.
> I meant to say as follows:
> I am working on developing WatchDog Driver for PowerPC4xx on Linux-2.6.
> Does anyone have a plan or a patch to make WatchDog Driver on 
> PowerPC4xx(405GP/405GPr/440GP/440GX) for Linux-2.6?

Are you looking for the old "ppc405 watchdog" driver that simply
hooked into the generic PPC heartbeat facility? Or are you looking
for a driver that utilizes the 4xx/booke hardware watchdog facility?

-Matt
