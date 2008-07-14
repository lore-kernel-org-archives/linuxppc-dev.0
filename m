Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAE1EDDF67
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:23:10 +1000 (EST)
Message-ID: <487B8B22.6050701@freescale.com>
Date: Mon, 14 Jul 2008 12:21:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Srinivasa D S <srinivasa@in.ibm.com>
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
References: <200807071952.27427.srinivasa@in.ibm.com>	<18554.33417.542066.185326@cargo.ozlabs.ibm.com>
	<200807141401.26917.srinivasa@in.ibm.com>
In-Reply-To: <200807141401.26917.srinivasa@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srinivasa D S wrote:

> +#define task_pt_regs(tsk)	(tsk)->thread.regs

Shouldn't this be:

	#define task_pt_regs(tsk)	((tsk)->thread.regs)

just to be safe?

-- 
Timur Tabi
Linux kernel developer at Freescale
