Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71D46DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:18:48 +1000 (EST)
Subject: Re: [PATCH] Quieten cache information at boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071014201431.GA23002@lixom.net>
References: <20071014193317.GC26693@kryten> <20071014201431.GA23002@lixom.net>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 07:18:34 +1000
Message-Id: <1192396714.6188.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-10-14 at 15:14 -0500, Olof Johansson wrote:
> On Sun, Oct 14, 2007 at 02:33:17PM -0500, Anton Blanchard wrote:
> > 
> > After 6 years the ppc64 kernel still thinks its important to tell me my
> > cache line size is 0x80 bytes. I think most people who care know that by
> > now. The rest probably cant even understand the hex output.
> > 
> > Since we might have misconfigured firmware or cpus that have a linesize
> > that isnt 128 bytes, I still print it out for those cases. If people
> > would prefer to remove it completely, lets do it.
> 
> Let's just remove it completely. I have yet to see a bug because of it,
> and we have 0x40 byte cache lines.

I did have issues because of incorrect cache line sizes recently... this
printk was actually useful for me :-)

Ben.
