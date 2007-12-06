Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45534DDF61
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 04:26:00 +1100 (EST)
Message-ID: <4758309F.6030001@freescale.com>
Date: Thu, 06 Dec 2007 11:25:51 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712061631.19485.arnd@arndb.de> <4758193B.5080707@freescale.com>
	<200712061658.08791.arnd@arndb.de> <47581C58.8060906@freescale.com>
	<7245C82C-BCFC-4E38-8685-8C17B4300341@freescale.com>
	<47581F7D.1040102@freescale.com>
In-Reply-To: <47581F7D.1040102@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:

> I think these patches are final:
> 
> [PATCH 1/2] qe: add function qe_clock_source (dated 12/3)
> [PATCH 2/2] ucc_geth: use rx-clock-name and tx-clock-name device tree 
> properties (dated 12/3)
> [PATCH v2] qe: add ability to upload QE firmware

I lied.  This last patch is missing a file.  v3 is coming soon.  Sorry.

-- 
Timur Tabi
Linux kernel developer at Freescale
