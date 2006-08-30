Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1443E67B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 19:46:02 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 30 Aug 2006 11:01:43 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <yf9mz9np82b.fsf@omoikane.mc.pp.se>
Message-ID: <20060830090143.44170@gmx.net>
MIME-Version: 1.0
References: <yf9bqq6p305.fsf@omoikane.mc.pp.se>	<20060829150759.269420@gmx.net>
	<yf9mz9np82b.fsf@omoikane.mc.pp.se>
Subject: Re: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system
To: Marcus Comstedt <marcus@mc.pp.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Tue, 29 Aug 2006 23:04:44 +0200
Von: Marcus Comstedt <marcus@mc.pp.se>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Betreff: Re: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system

> 
> "Gerhard Pircher" <gerhard_pircher@gmx.net> writes:
> 
> > Hi Marcus,
> >
> > I guess this message should also be forwarded to
> > linux-usb-devel@lists.sourceforge.net. I hope the developers there can
> > make some comments.
> >
> > Gerhard
> 
> 
> Well, I figured the first thing to do would be to reach a consensus
> here on whether or not atomic_t:s in DMA memory should be ruled as
> unallowed.  Judging from the massive silence, there doesn't seem to be
> any strong opinions either way though...
> 
> 
>   // Marcus
> 

You're right. Maybe it's a topic for the linuxppc-embedded mailing list, because mostly embedded platforms use the CONFIG_NOT_COHERENT_CACHE option.

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
