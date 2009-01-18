Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04331DDF57
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:57:20 +1100 (EST)
Subject: Re: [PATCH 9/10] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED v2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090118194353.85500@gmx.net>
References: <20081219051455.EBC28DE04A@ozlabs.org>
	<20090118194353.85500@gmx.net>
Content-Type: text/plain
Date: Mon, 19 Jan 2009 06:55:06 +1100
Message-Id: <1232308506.23611.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-01-18 at 20:43 +0100, Gerhard Pircher wrote:
> I'm pretty sure that the hack for setup_32.c above protects this code in hash_low_32.S/
> create_hpte() from being overwritten with nops. But I wonder which other paths exists
> in the memory management code to set the coherent flag in PTEs? Any ideas how I
> can get it to work without removing _PAGE_COHERENT from _PAGE_BASE?

I'll have a look, could be something with the BAT setup too, and I
haven't modified the 603 code, are you using a 603 ?

Ben.
