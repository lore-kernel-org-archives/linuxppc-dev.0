Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFA95DDF7C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 14:31:42 +1000 (EST)
Subject: Re: [PATCH] POWERPC: Get rid of leftover printk in isa-bridge.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1210264877.13845.274.camel@localhost.localdomain>
References: <1210264877.13845.274.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 May 2008 14:31:36 +1000
Message-Id: <1210307496.1421.134.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-08 at 11:41 -0500, Nate Case wrote:
> This printk() appears twice in the same function.  Only the latter one
> in the inval_range: section appears to be legitimate.
> 
> Signed-off-by: Nate Case <ncase@xes-inc.com>

Ack.
