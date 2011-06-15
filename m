Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5348B6F89
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 12:11:05 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Date: Wed, 15 Jun 2011 02:10:44 +0000
Message-ID: <4DF814A3.7070209@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop>
In-Reply-To: <1308103091.2635.13.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> We might want to generically have a CPU feature bit indicating we are
> running in guest vs. HV mode. I know Paulus is planning to introduce one
> so you may want to sync with him.

Are you talking about CPU_FTR_HVMODE_206?

--=20
Timur Tabi
Linux kernel developer at Freescale=
