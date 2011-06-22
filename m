Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CF13B6F62
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 16:21:22 +1000 (EST)
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20110622032013.GA28610@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413__14973.6630417921$1308385948$gmane$org@bloggs.ozlabs.ibm.com>
	<itq97v$dc$1@dough.gmane.org>
	<20110622032013.GA28610@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Jun 2011 16:17:46 +1000
Message-ID: <1308723466.32158.160.camel@pasglop>
Mime-Version: 1.0
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-22 at 13:20 +1000, Paul Mackerras wrote:
> On Tue, Jun 21, 2011 at 02:18:39PM +0000, Dmitry Eremin-Solenikov wrote:
> 
> > I have a Maple board (dual PPC970FX). Will this patchset work on it?
> > Should I add any additional changes to add support for this platform?
> 
> Provided the firmware gives you control in hypervisor mode, yes it
> should work, and I don't know of any extra changes you would need.
> I don't recall what firmware the Maple boards had on them, though.

I think it's more specifically whether the FW of the service processor
configure the mode rings of the 970 to "Apple" mode or not.

Cheers,
Ben.
