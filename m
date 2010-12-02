Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 30983B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 09:06:45 +1100 (EST)
To: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem with MPC5121 custom board.
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <765B188B547A48E7951D86ACC3544C54@ctag>
References: <765B188B547A48E7951D86ACC3544C54@ctag>
Date: Thu, 02 Dec 2010 23:06:40 +0100
Message-Id: <20101202220640.3FC07160696@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?=,

In message <765B188B547A48E7951D86ACC3544C54@ctag> you wrote:
> 
> We have a problem with custom design based on ads5121. May be you could
> provide us any clue about what may be happening.
> 
> Sometimes, when the board is powered-on:
> 
> - U-boot does not start (at least serial port does not output anything, I
> don't know if some piece of u-boot is executed).

In an overwhelming majority of such cases this is an indication of
incorrect and/or incomplete initialization of your system RAM. See the
FAQ at http://www.denx.de/wiki/view/DULG/UBootCrashAfterRelocation

Note that U-Boot related questions (and this is one) should better go
to the U-Boot mailing list instead (see
http://lists.denx.de/mailman/listinfo/u-boot)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You can only live once, but if you do it right, once is enough.
