Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1444EDDEBA
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 02:11:26 +1000 (EST)
In-Reply-To: <023132a5c5a4f07ec2d46b0515a55d4b@kernel.crashing.org>
References: <200705190953.l4J9rjO2024613@harpo.it.uu.se>
	<023132a5c5a4f07ec2d46b0515a55d4b@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e3e772afd2f56253d20d5332499cd7ff@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: gcc-4.2.0 breakage on powerpc?
Date: Sat, 19 May 2007 18:11:20 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Mikael Pettersson <mikpe@it.uu.se>,
	lkml Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> and we'll end up
>>>> having major kernel releases which don't build on i386 with major 
>>>> gcc
>>>> releases, which isn't altogether desirable.
>>>
>>> Yeah, like 4.2.0 with powerpc.  Seems like no one tested it :-(
>>
>> Details please. What exactly are the gcc-4.2.0 problems on powerpc?
>
> http://gcc.gnu.org/PR31490 .  Most stuff using named
> sections won't build; that includes CONFIG_MODULES.
> There is no viable workaround.  The problem is being
> handled.  I'll post a patch for the kernel refusing
> to build with this combination soon.

[Cc:ing the PowerPC list]

Oh btw, most likely this is a problem on 64-bit only.


Segher
