Return-Path: <gjaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 0C0D32BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 23:42:10 +1000 (EST)
From: Gerhard Jaeger <gjaeger@sysgo.com>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Wed, 27 Oct 2004 15:20:51 +0200
References: <20041026135847.A16409@home.com>
In-Reply-To: <20041026135847.A16409@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410271520.51333.gjaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Disable broken L2 cache on all 440GX revs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Dienstag 26 Oktober 2004 22:58, Matt Porter wrote:
> Always disable L2 cache on PPC440GX. All revs/speeds of silicon
> have parity error problems despite errata claims to the contrary.
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Hi Matt,

is there any test, with which you can reproduce these failures?
We have here custom boards based on the 440GX latest rev and 
we need to use them with enabled L2 cache...

TIA,
  Gerhard
