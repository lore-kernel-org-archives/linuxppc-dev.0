Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AADB3B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 04:27:54 +1100 (EST)
Date: Tue, 29 Mar 2011 12:26:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/4] KVM: PPC: e500: Introduce msr_block for e500v2
Message-ID: <20110329122640.075f416d@schlenkerla.am.freescale.net>
In-Reply-To: <76DF6B63-BCFC-4B8D-80A8-6C1578C6A22C@suse.de>
References: <20110328192558.GB11104@schlenkerla.am.freescale.net>
	<76DF6B63-BCFC-4B8D-80A8-6C1578C6A22C@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 Mar 2011 11:37:44 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 28.03.2011, at 21:25, Scott Wood wrote:
> 
> > From: yu liu <yu.liu@freescale.com>
> > 
> > In order to use lazy SPE register save/restore, we need to
> > know when the guest is using MSR[SPE].  In order to do that, we
> > need to control the actual MSR[SPE] separately from the guest's
> > notion of MSR[SPE].
> 
> Please make this generic for BookE. There's no reason to have FSL ifdefs in the code.

Yeah, I was wondering about that too.  Will respin.

-Scott
