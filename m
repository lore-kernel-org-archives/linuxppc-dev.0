Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 19618DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:39:00 +1000 (EST)
To: "Leopold Stotch" <l.butterz@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PSC in UART mode on TQM5200S
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Sep 2007 14:13:28 +0400."
	<53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com>
Date: Wed, 19 Sep 2007 00:38:57 +0200
Sender: wd@denx.de
Message-Id: <20070918223857.11329247FE@gemini.denx.de>
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

In message <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com> you wrote:
>
> So changed $HOME/linuxppc_2_4_devel/arch/ppc/platforms/tqm5200.h
> the following way:

Well, you have to unserstand *exactly* what the CPU and the board are
doing - the MPC5200 has multiplexed pins, and if you select one
function you lose a few others, so you must carefully check for
conflicts. Probably you will have to disable some other functions.
Also you have to usnerstand what the board is designed like - some
ports have specific and reserved functions.

Finally, there are such things like wrong baud rate on a serial port
which may make you think it's not working while you are just using bad
user mode settings.

> Is it possible to reconfigure all PSC's as UART's ?

Yes, it is. But you have to know what you are doing.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
All a hacker needs is a tight PUSHJ, a loose pair of UUOs, and a warm
place to shift.
