Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 90556DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 05:30:59 +1000 (EST)
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: libgcc_s.so needed when compiling with eldk4.1.0 and not with
	edlk3.1.1
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Mar 2007 13:14:34 +0200."
	<F1F6EC0C8B75034F9E3A79FC85122E8E71CD4C@aquib01a>
Date: Thu, 29 Mar 2007 21:30:57 +0200
Sender: wd@denx.de
Message-Id: <20070329193057.CD75D353A6C@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <F1F6EC0C8B75034F9E3A79FC85122E8E71CD4C@aquib01a> you wrote:
> 
> When I used eldk3.1.1 from denx the applications I compiled didn't need
> libgcc_s.so but now that I'm using eldk4.1.0, applications also require
> libgcc_s.so. Is it normal?

It depends on what you are doing.

Not all applications need this library (see my previous example).

But compilers in ELDK 3.1.1 (GCC-3.3.3) and ELDK  4.1  (GCC-4.0)  are
quite different, so of course different behaviour is normal.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
CAUTION:  The Mass of This Product Contains the Energy Equivalent  of
85 Million Tons of TNT per Net Ounce of Weight.
