Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 18F0D67DA7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 16:21:08 +1000 (EST)
Date: Wed, 4 Oct 2006 23:21:05 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20061005062105.GA1985@gate.ebshome.net>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<1159942128.13323.21.camel@localhost.localdomain>
	<7BD0D5CE-7BA3-43DC-B972-B75672F6A31E@embeddedalley.com>
	<1160005019.5887.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160005019.5887.30.camel@localhost.localdomain>
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

On Thu, Oct 05, 2006 at 09:36:59AM +1000, Benjamin Herrenschmidt wrote:
> Ugh ? Look at the #ifdef mess in ibm_emac...

Ugh?

I think you have to thank IBM/AMCC designers which keep changing bit 
layout of some registers, sometimes just changing polarity for no 
reason.

And with all due respect, Ben. Current ibm_emac despite of all "mess" 
is actually usable in production environment, which cannot be said 
about initial Armin version and second version you started but never 
got time to actually finish.

-- 
Eugene
