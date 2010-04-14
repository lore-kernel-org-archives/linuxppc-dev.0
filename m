Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C54C8B7D29
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 05:24:06 +1000 (EST)
To: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: mpc5121e-Real Time Clock
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <E70643A89AF74DE1BCA25C3C4AE2CE29@ctag>
References: <E70643A89AF74DE1BCA25C3C4AE2CE29@ctag>
Date: Wed, 14 Apr 2010 21:24:02 +0200
Message-Id: <20100414192402.63B68EEE8D8@gemini.denx.de>
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

In message <E70643A89AF74DE1BCA25C3C4AE2CE29@ctag> you wrote:
> 
> Looking in rtc-mpc5121.c code I didn't find anything related to Keep Alive
> Register (where TAMP bit is) so I would like to know where this issue is
> taking into account or if it is really being taking into account in the
> driver.

It is not.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To the systems programmer,  users  and  applications  serve  only  to
provide a test load.
