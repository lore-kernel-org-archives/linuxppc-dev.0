Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B89E8DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 07:54:44 +1100 (EST)
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45D316CD.9070901@freescale.com>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 07:54:33 +1100
Message-Id: <1171486473.20192.147.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-14 at 08:03 -0600, Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> 
> >> I just don't understand why it's okay to leave it there.
> > 
> > To make sure there is one. I suspect kernel bits might get upset if it's
> > absent.
> 
> That's not what I meant.  What I don't understand is: what's so special 
> about the 8272 that its DTS should have a 'chosen' section, but no other 
> DTS needs one?
> 
> Obviously, the kernel needs a 'chosen' section, and that's why U-Boot 
> adds one.  And since U-Boot adds one, the DTS itself doesn't need one. 
> Does the 8272 never use U-Boot?

I'm not talking specifically about the 8272. I think we should at it
back to all dts's

Ben.
