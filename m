Message-ID: <007901c1c894$d6c5b240$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Kim, Kwansuk" <kskim@neowave.co.kr>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <OMENKEONFDLIGLHPFALBIEDACHAA.kskim@neowave.co.kr>
Subject: Re: serial console on 405GP 
Date: Mon, 11 Mar 2002 09:36:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Kim,Kwansuk!

It seams you have the same problem that I had just two weeks ago.
It is likely you have the serial port located below 0xc0000000.
If it is so, I suggest you to move the serial port above 0xc0000000.
If you want to know the reason, just find the mails, in this mailing list, titled "Re: execve system call question"

- Sangmoon Kim -

----- Original Message -----
From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, March 07, 2002 11:42 AM
Subject: serial console on 405GP


>
> Dear, everyone!
>
> I'm poring linux-2.4.18-pre7 (from penquinppc.org) on my customized board (with IBM 405GP)
>
> My board has no keyboard, so I'm using serial console on UART0.
> I ported ppcboot, and it works well.
>
> When I ported linux on my board, there happened some problem.
>
> After init forks sash (standalone shell as you know),
> I can see the prompt of the sash but the character sent wasn't delivered to sash.
> So what character I send to the sash. It never respond.
>
> I watch for the serial source (driver/char/serial.c) and enabled DEBUG option and the character sent
> was received by kernel.
>
> I don't know why the characters are disappeared.
>
> Anyone know the reason?
>
> Please, help me.
>
>  ==============================================
>      Just for fun...
>                                                   - Linus Torvalds
>  ==============================================
>   Kwansuk Kim
>   Engineer, NeoWave Inc.
>   Tel   +82-31-380-4927    Fax +82-31-380-4747
>   E-mail: kskim@neowave.co.kr
> ==============================================
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
