Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECE9ADDEB7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 20:47:07 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47Al4nf008809
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 06:47:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47Al4CQ534766
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 06:47:04 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47Al49N012550
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 06:47:04 -0400
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070504055733.8FB7EDDFFD@ozlabs.org>
References: <20070504055733.8FB7EDDFFD@ozlabs.org>
Content-Type: text/plain
Date: Mon, 07 May 2007 05:41:33 -0500
Message-Id: <1178534493.3393.68.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-04 at 15:57 +1000, David Gibson wrote:
> +
> +config EBONY
> +       bool "Ebony"
> +       depends on 44x
> +       default y
> +       select 440GP
> +       help
> +         This option enables support for the IBM PPC440GP evaluation
> board. 

Given Paul's comment about config HOLLY being too generic, should this
be PPC_EBONY?

josh
