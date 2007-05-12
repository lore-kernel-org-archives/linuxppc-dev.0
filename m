Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD6FEDDEBB
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 00:08:24 +1000 (EST)
In-Reply-To: <20070511221304.a5a14f4e.sfr@canb.auug.org.au>
References: <46445455.608@freescale.com>
	<20070511221304.a5a14f4e.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7ba6dfe847f334f36560b84e291f2317@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] 83xx USB platform code rework
Date: Sat, 12 May 2007 16:07:38 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +		} else if (prop && !strcmp(prop, "serial")) {
>> +			if (!strcmp(of_get_property(np, "dr_mode", NULL), "otg")) {
>                                     
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Is there any chance that np doesn't have a "dr_mode" property?

Yes, of course -- you can never trust the incoming
device tree to be "correct".

Also, please no underscores in property names.


Segher
