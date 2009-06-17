Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B1C67B71CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 12:04:50 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7C478DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 12:04:46 +1000 (EST)
Date: Tue, 16 Jun 2009 22:04:43 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Update Warp defconfig
Message-ID: <20090616220443.6b590baa@lappy.seanm.ca>
In-Reply-To: <20090616112435.20f7b3d9@lappy.seanm.ca>
References: <20090616112435.20f7b3d9@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Jun 2009 11:24:35 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> I forgot to include the defconfig in the last set of patches. So you
> don't get to use the shiny new LEDS driver on the warp unless you turn
> it on.
> 
> Enabling hotplug is also very important since we have moved to udev on
> the warp.
> 
> Like most defconfig patches, most of the changes are just the normal
> kernel changes, not warp specific.
> 
> If it is too early, and we want to hold off until say rc4 with
> defconfigs I have no problem with that. I have tried to outline all
> the changes we specifically made. If anybody sees any bad choices with
> options, let me know!
> 
> Cheers,
>    Sean
> 
> * Enable GPIO LEDS
> * Enable LED triggers
> * Move to slub
> * Enable hotplug
> * Enable timestamps on printks
> * Enable UBIFS

Oops, missed an important option in the list:

* Enable in kernel config

If you use Pika's development environment (PADS), you need this
enabled. We use the config to enable certain features, mainly udev.
Without this config, we will assume you have an old Pika kernel without
new features.

Cheers,
   Sean
