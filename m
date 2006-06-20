Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8390367A79
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 19:50:53 +1000 (EST)
In-Reply-To: <20060620084726.GC30974@krispykreme>
References: <20060620084726.GC30974@krispykreme>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D0B9DD42-E1D3-48E3-A90A-8F8B5718852F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: support ibm,extended-*-frequency properties
Date: Tue, 20 Jun 2006 11:50:17 +0200
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> Support the ibm,extended-*-frequency properties found in recent POWER5
> firmware:
>
> cpus/PowerPC,POWER5@0/clock-frequency
>                  59aa5880 (1504336000)
> cpus/PowerPC,POWER5@0/ibm,extended-clock-frequency
>                  00000000 59aa5880
> cpus/PowerPC,POWER5@0/timebase-frequency
>                  0b354b10 (188042000)
> cpus/PowerPC,POWER5@0/ibm,extended-timebase-frequency
>                  00000000 0b354b10

Could you also allow the regular "timebase-frequency" property
to consist of two cells, with the same semantics?  That's what
some other systems do.  Hey, it'd simplify this code, if anything :-)

In fact, some kernel code already does this if I'm not mistaken
(the Cell port, perhaps?)


Segher
