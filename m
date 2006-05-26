Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7C7C67A76
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 11:18:04 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148553785.11759.12.camel@johannes.berg>
References: <1148553785.11759.12.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 26 May 2006 11:17:48 +1000
Message-Id: <1148606268.8089.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Once I have all these, I will, along with submitting snd-aoa [2], submit
> a patch to snd-powermac that makes it refuse loading in presence of a
> layout-id property as a first step to migrate to snd-aoa.
> 
> At the same time, I'll probably make i2sbus refuse attaching to a device
> unless there's a layout-id property so that it doesn't claim devices aoa
> doesn't handle yet.

I think we need to be careful about a couple other things:

 - We need non-pmf GPIO. Some layout-id based machines do need that,
like the mac mini
 - I'm tempted to rename soundbus/i2sbus to snd-aoa-soundbus and
snd-aoa-i2sbus (at least the module names) for now. 

Ben.
