Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 996A1DE264
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:41:12 +1000 (EST)
Subject: RE: [PATCH 5/5] Set IDE in ULI1575 to not native mode.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C307514@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
	<1179805110284-git-send-email-wei.zhang@freescale.com>
	<A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C307514@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:40:58 +1000
Message-Id: <1180525258.19517.261.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 10:25 +0800, Zhang Wei-r63237 wrote:
> 
> If the driver does not probe the irq itself, the driver will get wrong
> irq for lagecy IDE device.

Sorry, I didn't understand... care to explain in more details ?

Ben.
