Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9C1D1B7B91
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 06:35:08 +1100 (EST)
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mixing hard and soft floating point?
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se>
References: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
	<20091017181224.97FFBF15432@gemini.denx.de>
	<OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se>
Date: Sat, 17 Oct 2009 21:34:54 +0200
Message-Id: <20091017193454.7978FF15432@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Joakim Tjernlund,

In message <OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se> you wrote:
>
> > Recompile and relink it with soft-fp as well. Or ask the provider to
> > do that.
> 
> That is what I am trying do/find out. The supplier claims that
> it should not be a problem and is ATM unwilling to recompile the app/libs.
> I am not convinced won't cause problems, not to mention performance degradation.

If the application is really using FP instructions a lot, then there
is a huge difference between using soft-float and MATH_EMU; I
remember test cases where soft-float was faster by factors of
500...1000.

> OK, but then you don't mix some libs/apps with soft and other
> apps/libs with hard FP?

No, we never tried that. Sounds scary to me.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The connection between the language in which we think/program and the
problems and solutions we can imagine is very close. For this  reason
restricting  language  features  with  the intent of eliminating pro-
grammer errors is at best dangerous.
               - Bjarne Stroustrup in "The  C++ Programming Language"
