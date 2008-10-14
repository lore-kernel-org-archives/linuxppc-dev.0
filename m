Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 888A4DDF31
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 09:02:33 +1100 (EST)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Siewior <bigeasy@linutronix.de>
In-Reply-To: <1224012320.7879.79.camel@localhost.localdomain>
References: <20080901142302.GA13754@www.tglx.de>
	<1224012320.7879.79.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 17:02:12 -0500
Message-Id: <1224021732.7879.100.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 14:25 -0500, Nate Case wrote:
> 
>         -mno-spe: Deprecated way to say "no SPE instructions"
>         -mspe=no: New way to do -mno-spe

Sorry, I got this backwards (as Kumar pointed out in his other reply).
-mspe=no is actually deprecated.

- Nate Case <ncase@xes-inc.com>
