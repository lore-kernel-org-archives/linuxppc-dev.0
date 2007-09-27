Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D657DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 07:32:26 +1000 (EST)
In-Reply-To: <20070927195351.GE7838@mag.az.mvista.com>
References: <11909173512321-git-send-email-ljd015@freescale.com>
	<20070927191036.GD7838@mag.az.mvista.com>
	<C908B0B881A6B949985D6BAA0D9469B402CD36A7@az33exm20.fsl.freescale.net>
	<20070927195351.GE7838@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1AD9B821-ABC8-4007-99C5-363521E40349@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
Date: Thu, 27 Sep 2007 16:31:53 -0500
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: D'Abbraccio Joe-ljd015 <Joe.D'abbraccio@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 27, 2007, at 2:53 PM, Mark A. Greer wrote:

> On Thu, Sep 27, 2007 at 12:41:57PM -0700, D'Abbraccio Joe-ljd015  
> wrote:
>> Thanks for the advice, but I was just basing the list to post to  
>> on the
>> MAINTAINERS file which states that this is the one for Embedded  
>> PPC83XX.
>> If you still think that I should post to linuxppc-dev, let me know.
>
> Yes, I think it would be better to repost to linuxppc-dev.
>
> Does anyone have an objection to changing all of the:
>
> 	"L:	linuxppc-embedded@ozlabs.org"
>
> in MAINTAINERS to:
>
> 	"L:	linuxppc-dev@ozlabs.org" ??
>
> Kumar, Josh, Vitaly, et. al.?

I'm all for it, but we should see about killing linuxppc-embedded and  
just move everyone to linuxppc-dev.

- k
