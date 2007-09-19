Return-Path: <l.butterz@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 56D1ADDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 17:40:08 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so305588pyi
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 00:40:07 -0700 (PDT)
Message-ID: <53b5d6e90709190040p16571ab9x7fce2c527810de37@mail.gmail.com>
Date: Wed, 19 Sep 2007 11:40:07 +0400
From: "Leopold Stotch" <l.butterz@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: PSC in UART mode on TQM5200S
In-Reply-To: <20070918223857.11329247FE@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com>
	<20070918223857.11329247FE@gemini.denx.de>
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

Thank you for the answer, Wolfgang !
Yes, we made a custom board which implements UART's
instead of USB, keyboard, mouse and others...
I checked the baudrate and i think it's ok.
Can you tell me, please, is there any HOWTO about MPC5200's
PSC's reconfiguration or something for newbies ?


On 9/19/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com> you wrote:
> >
> > So changed $HOME/linuxppc_2_4_devel/arch/ppc/platforms/tqm5200.h
> > the following way:
>
> Well, you have to unserstand *exactly* what the CPU and the board are
> doing - the MPC5200 has multiplexed pins, and if you select one
> function you lose a few others, so you must carefully check for
> conflicts. Probably you will have to disable some other functions.
> Also you have to usnerstand what the board is designed like - some
> ports have specific and reserved functions.
>
> Finally, there are such things like wrong baud rate on a serial port
> which may make you think it's not working while you are just using bad
> user mode settings.
>
> > Is it possible to reconfigure all PSC's as UART's ?
>
> Yes, it is. But you have to know what you are doing.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> All a hacker needs is a tight PUSHJ, a loose pair of UUOs, and a warm
> place to shift.
>


-- 
Best regards,
Leopold Stotch
