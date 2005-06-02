Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4463679E2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2005 09:07:46 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <429F892C.7030603@am.sony.com>
References: <1117424155.5228.28.camel@gaston> <429F892C.7030603@am.sony.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 09:06:58 +1000
Message-Id: <1117753618.31082.99.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-06-02 at 15:33 -0700, Geoff Levand wrote:
> I had a problem when building for ppc440 (gcc -m405).  I wonder if we 
> need some conditionals on the DSSALL statement as below, or is DSSALL 
> intended to be a perprocessor macro that would expand to a blank line
> in this case?

No, but the cpu feature bit will make the dssall be nop'ed out on your
CPU. I though we were passing -many to gas in all cases, don't we ?

Ben.
