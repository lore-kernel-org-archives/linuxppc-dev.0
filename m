Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FC4E67A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 09:11:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
In-Reply-To: <4240b91605040504525fd877e5@mail.gmail.com>
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
	<1112656372.26086.88.camel@gaston>
	<4240b91605040504525fd877e5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 09:11:20 +1000
Message-Id: <1112742680.9518.43.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-04-05 at 13:52 +0200, Jerome Glisse wrote:
> I almost successfully run the 2.6.12-rc2, there were some
> bad old stuff lying around. But i needed the two workaround
> to compile it. So maybe this two could be applied to the kernel ?
> 
> Now the only issue which remains is that the radeon framebuffer
> no more set a proper mode for my screen. The screen complain
> about a out of range mode. But as soon as X start i get a proper
> mode set but can't switch to console.
> 
> The screen is a crt one on a radeon 9600 with dvi->vga adapter.
> Which works well on 2.6.10
> 
> I will try t look at radeon framebuffer see if i can find anythings.
> Any idea of which change on that code may be the origin of this ?

radeonfb picks the first mode in the list generated from DDC, which
unfortunately, on a lot of CRTs, is bullshit...

Ben.
