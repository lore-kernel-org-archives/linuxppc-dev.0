Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D3127DDFBA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:41:41 +1000 (EST)
Date: Tue, 7 Apr 2009 09:41:38 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
In-Reply-To: <20090407022743.GA12174@lixom.net>
Message-ID: <alpine.LRH.2.00.0904070941140.17130@vixen.sonytel.be>
References: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
	<20090407022743.GA12174@lixom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Apr 2009, Olof Johansson wrote:
> On Tue, Apr 07, 2009 at 12:00:41PM +1000, Michael Ellerman wrote:
> > Add an option, on by default, to build all code under arch/powerpc with
> > -Werror, which causes gcc to treat warnings as errors.
> > 
> > The intention is to make it harder for people to inadvertantly introduce
> > errors in the arch/powerpc code. It needs to be configurable so that
> > if a warning is introduced, people can easily work around it while it's
> > being fixed.
> 
> This looks useful at least for the automated builds to catch new warnings,
> but do similar options exist on other architectures, x86 in particular? I
> think a Cc to LKML of this could be useful.
> 
> This is really only beneficial if various people build for powerpc often
> enough. If major subsystem maintainers aren't going to hit the errors
> it's more of a hinderance for PPC than a global benefit, right?

Will be built nightly: http://kisskb.ellerman.id.au/kisskb/matrix/

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
