Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC43D679EA
	for <linuxppc-dev@ozlabs.org>; Sun, 29 May 2005 08:34:33 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jewtpjjh2m.fsf@sykes.suse.de>
References: <1117246520.5228.5.camel@gaston>  <jewtpjjh2m.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sun, 29 May 2005 08:29:28 +1000
Message-Id: <1117319369.5228.12.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: PowerMac PM rework
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-05-28 at 21:17 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Please test and report any issue.
> 
> With this patch my iBook G3 no longer wakes up by opening the lid.  I have
> to touch the keyboard to wake it up.

Yup, that's a minor issue, the lid wakeup option lost it's default
value :) Will be fixed in the next version of the patch.

Ben.
