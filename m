Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 48F91DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 06:04:12 +1100 (EST)
To: "Naveen Kumar" <naveenkumar_v@infotechsw.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Regarding MPC5200
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <200811240740.mAO7eS4X013348@mail.infotechsw.com>
References: <200811240740.mAO7eS4X013348@mail.infotechsw.com>
Date: Mon, 24 Nov 2008 19:56:35 +0100
Message-Id: <20081124185635.26EA3834B03E@gemini.denx.de>
Cc: 'Joaquin Luna' <Joaquin.Luna@jdsu.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Naveen Kumar,

In message <200811240740.mAO7eS4X013348@mail.infotechsw.com> you wrote:
>
> I am using the MPc5200 processor(TQM5200) board with stk5200 base board for
> porting embedded Linux kernel 2.4.25 denx distribution with U-boot loader.

There is full support for the TQM5200 / STK5200 in mainline. Please
use a recent 2.6 kernel for any current work.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never underestimate the bandwidth of a station wagon full of tapes.
                                -- Dr. Warren Jackson, Director, UTCS
