Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id DB3BADDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 09:21:20 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3344372wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Nov 2007 14:21:19 -0800 (PST)
Message-ID: <9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>
Date: Wed, 7 Nov 2007 17:21:19 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
In-Reply-To: <4732396D.4040904@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
	<4732396D.4040904@genesi-usa.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm not in favor of all these fsl prefixes. These chip families do get
sold. What would we have done with intel,pxa320 all over the place
when they sold it to marvell? mass changes to marvell,pxa320?

The mpc/pxa parts numbers don't get changes when chip families get sold.

-- 
Jon Smirl
jonsmirl@gmail.com
