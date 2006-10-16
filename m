Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 877E067A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 06:01:47 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9GK1hup006626
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 16:01:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9GK1hsj512410
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 14:01:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9GK1hNr015223
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 14:01:43 -0600
Subject: Re: [PATCH] fix ARCH=ppc timer_interrupt after global pt_regs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <871wp8ukh0.fsf@sleipner.barco.com>
References: <871wp8ukh0.fsf@sleipner.barco.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 15:05:48 -0500
Message-Id: <1161029148.3172.19.camel@zod.rchland.ibm.com>
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

On Mon, 2006-10-16 at 21:30 +0200, Peter Korsgaard wrote:
> Hi,
> 
> 2.6.19-rc2 doesn't boot on arch/ppc (atleast of 4xx), because the
> 'global-pt_regs' megapatch forgot to fix up the arch/ppc
> timer_interrupt handler. This patch fixes it.

Kumar Galak already fixed this on Oct 11 in the powerpc git tree.

Paul, could you send this fix to Linus soon please?

josh
