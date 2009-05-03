Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C49FDDDE07
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 05:33:21 +1000 (EST)
To: Sean MacLennan <smaclennan@pikatech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: unexpected non-allocatable section
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20090503123959.0cc5c967@lappy.seanm.ca>
References: <20090502224126.641c63bf@lappy.seanm.ca>
	<20090503204546.691ec6e7.sfr@canb.auug.org.au>
	<20090503123959.0cc5c967@lappy.seanm.ca>
Date: Sun, 03 May 2009 21:33:16 +0200
Message-Id: <20090503193316.E72BC83420E8@gemini.denx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Sean MacLennan,

In message <20090503123959.0cc5c967@lappy.seanm.ca> you wrote:
> 
> > What gcc, binutils versions and config are you using?
> 
> gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)
> GNU assembler version 2.16.1 (powerpc-linux) using BFD version 2.16.1
> 
> And this is all running on the Warp with a 440EP.

Which exact commands did you use to build the kenrel, and how did you
set (and export?) the CROSS_COMPILE environment variable?

The thing is, that I cannot reproduce this - I tested it with
v2.6.30-rc4, both with ELDK 4.1 (as you) and ELDK 4.2.

Both build the kernel image without any such warnings.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.
