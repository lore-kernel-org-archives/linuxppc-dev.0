Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFA8DDDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 02:21:14 +1100 (EST)
Message-ID: <49242ECD.6000604@freescale.com>
Date: Wed, 19 Nov 2008 09:20:45 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: udbg based backend for hvc_console
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
	<20081118004005.GC26336@yookeroo.seuss>
	<ed82fe3e0811172042r1d4887f8n76682e0b21555372@mail.gmail.com>
	<20081118051408.GM26336@yookeroo.seuss>
	<4922D9E9.5020204@freescale.com>
	<20081119004220.GE29577@yookeroo.seuss>
In-Reply-To: <20081119004220.GE29577@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Um.. yeah.. I'm a bit baffled by this.. all the existing backends
> are listed after hvc_console, I just added hvc_udbg to the end.  I
> didn't really understand the rationale in that commit, but then I
> haven't had time to look at it very much yet.

No, some are before:

obj-$(CONFIG_HVC_RTAS)          += hvc_rtas.o	<---
obj-$(CONFIG_HVC_BEAT)          += hvc_beat.o	<---
obj-$(CONFIG_HVC_DRIVER)        += hvc_console.o
obj-$(CONFIG_HVC_IRQ)           += hvc_irq.o
obj-$(CONFIG_HVC_XEN)           += hvc_xen.o
obj-$(CONFIG_HVC_UDBG)          += hvc_udbg.o

Until your patch, only Xen was wrong.

-- 
Timur Tabi
Linux kernel developer at Freescale
