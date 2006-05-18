Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84ADC67B31
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:22:19 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673062C064E@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673062C064E@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 17:22:09 +1000
Message-Id: <1147936929.17679.106.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 15:12 +0800, Zang Roy-r61911 wrote:
> > I'm not repeating Kumar's comments about that CONFIG_7xxx 
> > thing and that
> > 7xxx/ directory, it should all go.
> > 
> 
> Should I move my code to embedded6xx?

Probably for now yes.

> I will get rid of those tables.  I can see that in file
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c (2.6.17-rc4), there is
> a similar table. Should it be removed in future :)?

Yes. And somebody beaten up for letting that stuff leak into
arch/powerpc :)

> > Yes, please do so, we will not accept a board that does the above :)
> 
> I just do the same thing as 85xx :).

Yes and I intend to LART Kumar seriously for that next time I meet
him :)

> > We need a generic add_bridge that goes through PCI bridges and
> > instanciate based on their type as provided by the device-tree. You
> > should try to work in that direction...

I suggest you also read my comments to Mark A. Greer as most of that
stuff overlaps... I wish I had more times to work myself on that but I'm
fairly overflowed at the moment...

Ben
