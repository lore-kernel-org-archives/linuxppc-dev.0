Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BF8B8DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Mar 2008 12:27:40 +1100 (EST)
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: TQM5200 2.6-denx SM501 voyager enabling problem.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Mar 2008 15:10:07 +0100."
	<BLU106-W13F58AFC51977B5ACB4318CA130@phx.gbl>
Date: Sat, 08 Mar 2008 02:27:37 +0100
Sender: wd@denx.de
Message-Id: <20080308012738.0C3D9247AF@gemini.denx.de>
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

In message <BLU106-W13F58AFC51977B5ACB4318CA130@phx.gbl> you wrote:
> 
> I thought about this possible solution (adding resource description to device tree), but as far as I understood, the device tree was intended to describe the microcontroller peripherals and tqm5200, based on the mpc5200 is sold out also without sm501, s
> o that's why I discarded this option.

The device tree describes the hardware, and the TQM5200 (with  SM501)
and  the  TQM5200S  (without  the SM501) are two different boards and
need different device trees.


And, Pedro - could you please restrict your line length to some 70+
characters or so? Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The greatest warriors are the ones who fight for peace."
- Holly Near
