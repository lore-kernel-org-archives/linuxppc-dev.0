Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F04BDDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 02:39:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9IGdPZV016173
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:39:26 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9IGdPF3013174
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:39:25 -0500 (CDT)
Message-ID: <47178C3D.4070309@freescale.com>
Date: Thu, 18 Oct 2007 11:39:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: qe: add ability to upload QE firmware
References: <11927201051427-git-send-email-timur@freescale.com>
In-Reply-To: <11927201051427-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
> on how to upload it.  Add function qe_upload_microcode() to parse the blob
> and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
> include the actual RISC Special Registers.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

I need to add a few fields to the structure, but I would still appreciate 
comments on the structure and the corresponding code.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
