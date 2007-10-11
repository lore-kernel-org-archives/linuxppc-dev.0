Return-Path: <SRS0=DCot=PF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 730FFDDF9B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 16:10:41 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Add AMCC Kilauea eval board support to
	platforms/40x
Date: Thu, 11 Oct 2007 08:06:01 +0200
References: <200710081108.51625.sr@denx.de> <200710091334.16682.sr@denx.de>
	<1192045466.5534.60.camel@localhost.localdomain>
In-Reply-To: <1192045466.5534.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710110806.02233.sr@denx.de>
Cc: Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 October 2007, Josh Boyer wrote:
> > > Do you really need config options for 405EP/EX? I don't seem them used
> > > anywhere else in the code (and it's also contradictory to the whole new
> > > multiplatform way of looking at stuff :).
> > >
> > > I know the 405/440 is still somewhat #ifdef:ed on the cpu here and
> > > there, but since this doesn't add any such code I don't see a need for
> > > the config options?
> >
> > Yes, I'm still used to needing these defines from arch/ppc (for example
> > for the 4xx EMAC driver). But its possible, that we really don't need it
> > at all in arch/powerpc with all the device tree information. Not sure
> > though.
> >
> > Josh, what do you think? Should I remove the 405EX define completely?
>
> If it's not needed, it can go.  As Olof said, it doesn't appear to be
> used anywhere in the code so I think it's fine.

OK, I'll remove it. If we later see that we need it, we can always add it 
again.

> One question I do have is if 405EX and 405EP need any of the 405GP
> errata config options selected.  I would like to think those don't apply
> because the hardware is fixed, but I haven't checked to be sure.

Yes, the 2 405 errata's IBM405_ERR51 and IBM405_ERR77 do not apply to "newer" 
405 cores. Only 405GP (and 405CR I assume) are affected.

Best regards,
Stefan
