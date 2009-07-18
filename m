Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A7531B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 23:02:26 +1000 (EST)
To: Valentine <vbarshak@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Simple question about powerpc asm.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A61A48D.8060601@ru.mvista.com>
References: <4A6194D8.9090602@gmail.com> <4A61A48D.8060601@ru.mvista.com>
Date: Sat, 18 Jul 2009 14:54:52 +0200
Message-Id: <20090718125452.3760D832E416@gemini.denx.de>
Cc: HongWoo Lee <hongwoo7@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Valentine,

In message <4A61A48D.8060601@ru.mvista.com> you wrote:
>
> PowerPC instructions are 32-bit long. So, there are only 16 bits 
> available within the instruction for constant values. Since address can 
> be up to 64 bits, we have to load it a piece at a time. The "@" within 
> the assembler instruct it to give a specially-processed form of a symbol 
> value:
> 
> @highest -- refers to bits 48-63 of a constant
> @higher -- refers to bits 32-47 of a constant
> @h -- refers to bits 16-31 of a constant
> @l -- refers to bits 0-15 of a constant

Actually these bit numbers are wrong, as bit 0 is the MSB for PowerPC
;-)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Emotions are alien to me.  I'm a scientist.
	-- Spock, "This Side of Paradise", stardate 3417.3
