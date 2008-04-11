Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 39A79DE1CC
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 23:54:10 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so147562anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 06:54:04 -0700 (PDT)
Message-ID: <fa686aa40804110654k13e823c4v1d87d6a7cfd7034f@mail.gmail.com>
Date: Fri, 11 Apr 2008 07:54:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH 1/5] phylib: don't create a phydev for ID-less PHYs.
In-Reply-To: <1207910826.9544.26.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
	<1207897589.9544.13.camel@gentoo-jocke.transmode.se>
	<200804111006.04708.sr@denx.de>
	<1207910826.9544.26.camel@gentoo-jocke.transmode.se>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Gortmaker <paul.gortmaker@windriver.com>, linux-net@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 4:47 AM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
>
>  On Fri, 2008-04-11 at 10:06 +0200, Stefan Roese wrote:
>  > On Friday 11 April 2008, Joakim Tjernlund wrote:
>  > > PHY ID 0x0 isn't an invalid id, I got a Broadcom PHY that has
>  > > PHY ID=0. Maybe I am misunderstanding something?
>  >
>  > IIRC, address 0 is the PHY broadcast address, but can be used without problem
>  > with some PHY's. I remember some designs were we had the PHY at address 0.
>
>  Ouh, if that is so, I guess we need a CONFIG option or a new mdio bus
>  property to select if PHY ID 0 is valid id or not.

Or, don't probe for phys by default.  Rather, use the data in the
device tree to determine what PHY ids are valid.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
