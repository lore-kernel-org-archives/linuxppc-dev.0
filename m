Return-Path: <david.hagood@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 1AE08B70F8
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 20:50:31 +1000 (EST)
Received: by gwb19 with SMTP id 19so1536141gwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 03:50:30 -0700 (PDT)
Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
From: David Hagood <david.hagood@gmail.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
In-Reply-To: <52CF90264091A14888078A031D780F4306C8C176@ism-mail03.corp.ad.wrs.com>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
	<1285240268.2454.8.camel@chumley>
	<52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>
	<409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C176@ism-mail03.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 05:50:25 -0500
Message-ID: <1285325425.2454.11.camel@chumley>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-09-24 at 07:09 +0200, Chen, Tiejun wrote:

> 
> Right but this should be done for RC mode, not for EP mode we're
> discussing.
> 
> Tiejun

According to the Freescale documentation, outbound is just as valid for
endpoint as for root complex - indeed, to generate MSIs from software
REQUIRES programming an outbound ATMU to access the host's APIC.

Moreover, ANY PCI endpoint SHOULD be able to do bus master access, and
that is done by the outbound ATMUs.
