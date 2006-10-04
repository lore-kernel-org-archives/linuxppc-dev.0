Return-Path: <tim.bird@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD25567DBA
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 03:59:33 +1000 (EST)
Message-ID: <4523EF39.50107@am.sony.com>
Date: Wed, 04 Oct 2006 10:28:25 -0700
From: Tim Bird <tim.bird@am.sony.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>	<20060927165556.04c8d5d7@vitb.ru.mvista.com>	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>	<20060927112201.293fef44@localhost.localdomain>	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>	<17699.769.632098.479906@cargo.ozlabs.ibm.com>
	<2867EA41-5135-43F7-9873-044C617EAC1B@embeddedalley.com>
In-Reply-To: <2867EA41-5135-43F7-9873-044C617EAC1B@embeddedalley.com>
Content-Type: text/plain; charset=UTF-8
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> I'm not against using the device tree (or platform data
> or #defines) when it's appropriate to do so.  I think our
> obsession to represent everything there is what is
> creating the complexity.  If a #define in a board
> specific port file makes sense, then just do that,
> even if it is a BSCR address.  The device tree just
> seems like the new toy that everyone wants to play
> with, and we are forgetting that the old fashioned way
> of just writing some C code may be the way
> to implement what we need.

I'd like to "second" a lot of what Dan is saying.

Linux increasingly drifts away from simple, adequate
solutions (that admittedly require a bit of embedded
developer elbow grease), towards these types of
"grand unification" schemes, which actually interfere
with goals in the embedded space.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
