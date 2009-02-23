Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2FD8DDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 14:52:04 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: provide APIs for validating and updating DABR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20090217125122.5bbf713b@thinkcentre.lan>
References: <20090217125122.5bbf713b@thinkcentre.lan>
Content-Type: text/plain
Date: Mon, 23 Feb 2009 14:51:58 +1100
Message-Id: <1235361118.8805.225.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +/* for reprogramming DABR/DAC during restart of a checkpointed task */
> +extern bool debugreg_valid(unsigned long val);
> +extern void debugreg_update(struct task_struct *task, unsigned long val);
> +

Please keep the "index" here. We may want to add support for IABR, and
there is some WIP to add support for multiple DACs and IACs on BookE
processors.

Cheers,
Ben.
