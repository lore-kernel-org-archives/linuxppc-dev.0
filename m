Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B540EDDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 07:33:59 +1100 (EST)
Subject: Re: [PATCH 1/2] [POWERPC] smp_call_function_map should be static
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071228040836.GA23635@lixom.net>
References: <20071228040836.GA23635@lixom.net>
Content-Type: text/plain
Date: Wed, 02 Jan 2008 07:28:33 +1100
Message-Id: <1199219313.6751.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-27 at 22:08 -0600, Olof Johansson wrote:
> smp_call_function_map should be static, and for consistency prepend it
> with __ like other local helper functions in the same file.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

NAK. I want it exported to other arch code, I'll need it in some stuff
that I haven't released yet, like some BookE SMP stuff.

Ben.
