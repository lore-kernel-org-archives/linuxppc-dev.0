Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B337ADDFD4
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 07:29:45 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 18 Jan 2009 21:29:43 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1232308506.23611.43.camel@pasglop>
Message-ID: <20090118202943.85450@gmx.net>
MIME-Version: 1.0
References: <20081219051455.EBC28DE04A@ozlabs.org>	
	<20090118194353.85500@gmx.net> <1232308506.23611.43.camel@pasglop>
Subject: Re: [PATCH 9/10] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED v2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 19 Jan 2009 06:55:06 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: paulus@samba.org, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH 9/10] powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED v2

> On Sun, 2009-01-18 at 20:43 +0100, Gerhard Pircher wrote:
> > I'm pretty sure that the hack for setup_32.c above protects this code in hash_low_32.S/
> > create_hpte() from being overwritten with nops. But I wonder which other paths exists
> > in the memory management code to set the coherent flag in PTEs? Any ideas how I
> > can get it to work without removing _PAGE_COHERENT from _PAGE_BASE?
> 
> I'll have a look, could be something with the BAT setup too, and I
> haven't modified the 603 code, are you using a 603 ?
No, it's a 7455 (which has CPU_FTR_NEED_COHERENT set in its CPU features).

Thanks!

Gerhard
-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a
