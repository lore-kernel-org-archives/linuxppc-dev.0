Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id ECB22DDF00
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:57:34 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 04/12] mpc5121: Added reset module registers
	representation.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A01F33B.2090100@freescale.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-5-git-send-email-wd@denx.de>
	<4A01F33B.2090100@freescale.com>
Date: Wed, 06 May 2009 23:57:31 +0200
Message-Id: <20090506215731.3D39B83420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Scott,

in message <4A01F33B.2090100@freescale.com> you wrote:
>
> > --- a/arch/powerpc/include/asm/mpc512x.h
> > +++ b/arch/powerpc/include/asm/mpc512x.h
...
> 83xx has the same registers; we should define it in a non-512x-specific 
> header.

Agreed. Any suggestion where?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I know engineers. They love to change things.             - Dr. McCoy
