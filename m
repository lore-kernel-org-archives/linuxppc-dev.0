Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 8E64767A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 09:25:36 +1100 (EST)
Date: Wed, 23 Feb 2005 15:25:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Chapman <jchapman@katalix.com>
Message-ID: <20050223222534.GM345@smtp.west.cox.net>
References: <421CEC19.2010703@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421CEC19.2010703@katalix.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PATCH: add ppc PVR register values for 7447A and 7457 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2005 at 08:48:25PM +0000, James Chapman wrote:
> Signed-off-by: James Chapman <jchapman@katalix.com>
> 
> Trivial patch to add 7447A and 7457 CPU defs.

Why?  Most of the PVR definitions here can be removed (*muttering about
85xx ones being added).

-- 
Tom Rini
http://gate.crashing.org/~trini/
