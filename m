Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E26CF67B19
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 07:55:30 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Date: Sat, 23 Apr 2005 23:55:21 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHOEIJCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <31d4fa0af2a0d11f029d675ae5bd331c@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Apr 23, 2005, at 8:42 AM, Marcelo Tosatti wrote:
> 
> >> Does CONFIG_PIN_TLB make a difference?
> >
> > No it does not.
> 
> For some reason this option and code didn't make it from
> 2.4 to 2.6.  It should have some effect on small memory (16Mbyte)
> systems with processor that have more than 16 TLB entries.

Oh, but the CONFIG_PIN_TLB code in head_8xx.S is there. I guess something is missing.

 Jocke
