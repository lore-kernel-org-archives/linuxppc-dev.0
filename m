Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F901DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 02:18:05 +1100 (EST)
Message-ID: <475FFBA3.9080607@freescale.com>
Date: Wed, 12 Dec 2007 09:17:55 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
References: <11970422334145-git-send-email-timur@freescale.com>
In-Reply-To: <11970422334145-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Define the layout of a binary blob that contains a QE firmware and instructions
> on how to upload it.  Add function qe_upload_firmware() to parse the blob
> and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
> include the actual RISC Special Registers.  Added description of a new
> QE firmware node to booting-without-of.txt.

If there are no objections, I'd like this patch to be pulled into for-2.6.25. 
Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
