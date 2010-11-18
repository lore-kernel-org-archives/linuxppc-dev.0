Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 865C6B71DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 08:04:11 +1100 (EST)
Received: from mail72-am1 (localhost.localdomain [127.0.0.1])	by
	mail72-am1-R.bigfish.com (Postfix) with ESMTP id 88EFC190031B	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 20:48:55 +0000 (UTC)
Received: from AM1EHSMHS001.bigfish.com (unknown [10.3.201.253])	by
	mail72-am1.bigfish.com (Postfix) with ESMTP id 46B78E7804C	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 20:48:55 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAIKmhE5013545	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 13:48:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAIL55MD017347	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 15:05:05 -0600 (CST)
Date: Thu, 18 Nov 2010 14:48:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: <steven.lin@teradyne.com>
Subject: Re: application needs fast access to physical memory
Message-ID: <20101118144841.0910d73a@udp111988uds.am.freescale.net>
In-Reply-To: <OF40046BB1.06061608-ON882577DF.00711C8B-862577DF.00721D60@notes.teradyne.com>
References: <20101118133549.1c6d2cc3@udp111988uds.am.freescale.net>
	<OF40046BB1.06061608-ON882577DF.00711C8B-862577DF.00721D60@notes.teradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Nov 2010 14:46:16 -0600
<steven.lin@teradyne.com> wrote:

> Hello Scott,
> 
> Do you know whether this patch is necessary if I were to use alloc_bootmem
> () (to set aside a region of contiguous physical memory) instead of the
> kernel parameter "mem=256"?

It should not be needed in that case.

-Scott
