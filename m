Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6459FDDEF7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jan 2009 04:10:46 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
Date: Wed, 31 Dec 2008 18:10:17 +0100
Message-Id: <20081231171017.6FCF585AD247@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Kumar,

In message <1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org> you wrote:
> 
> > This is how FSL U-Boots configure the cfg window, and I'm trying to
> > retain the compatibility. Anyway, now Linux maps only the first 4kB
> > of that area, so we don't actually care about this, but dts is still
> > correct for older u-boots. Newer U-Boots might want to correct this
> > value if they want to use other cfg window setup...
> 
> I'd rather not pollute the .dts with this since I don't believe the  
> open source u-boot supports PCIe on 83xx.

What exactly do you mean by "open source u-boot"?  You  don't  really
mean that there are propriatary (closed source) versions of U-Boot in
Freescale,  or  are  you?  I  iknow that you know that it's GPL, so I
guess that was just an unlucky phrase?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>
