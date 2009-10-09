Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6A07B7B8D
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 17:30:09 +1100 (EST)
Subject: Re: [PATCH 2/6] 8xx: Update TLB asm so it behaves as linux mm expects.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF6A111C97.D8A7A6A3-ONC125764A.00210BB5-C125764A.002271AC@transmode.se>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255008298-19949-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255008298-19949-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255035843.2146.39.camel@pasglop>
	<OF0E7CD530.5EA71A5E-ONC1257649.00797FD2-C1257649.007CEF55@transmode.se>
	<1255049611.2355.20.camel@pasglop>
	<OF6A111C97.D8A7A6A3-ONC125764A.00210BB5-C125764A.002271AC@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 17:30:01 +1100
Message-Id: <1255069801.2861.2.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 08:16 +0200, Joakim Tjernlund wrote:

> Which will be fixed once I activate:
> #if 0 /* Not yet */
> 	/* Honour kernel RO, User NA */
> 	andi.	r11, r10, _PAGE_USER | _PAGE_RW
> 	bne-	cr0, 5f
> 	ori	r10,r10, 0x200 /* Extended encoding, bit 22 */
> #endif

Which will be more code including a conditional than my proposed
trick :-) I'll try to write the asm for you later.

> Not convinced that your trick will be a win. The other
> bits will need to move around too. Maybe I misunderstand
> something?

I'll write some code to show you what I have in mind later.

Cheers,
Ben.
