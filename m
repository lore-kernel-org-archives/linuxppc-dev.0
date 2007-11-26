Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FC6CDDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:26:55 +1100 (EST)
Message-ID: <474B01F5.2020702@freescale.com>
Date: Mon, 26 Nov 2007 11:27:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [RFC/PATCHv4] powerpc: Move CPM command handling into the cpm
	drivers
References: <474AFC6C.9020007@scram.de>
In-Reply-To: <474AFC6C.9020007@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> This patch moves the CPM command handling into commproc.c
> for CPM1 and cpm2_common.c. This is yet another preparation
> to get rid of drivers accessing the CPM via the global cpmp.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
