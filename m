To: Todd <to_dd@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot boot-up question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Feb 2004 13:39:49 PST."
             <20040202213949.30276.qmail@web40408.mail.yahoo.com>
Date: Mon, 02 Feb 2004 23:26:12 +0100
Message-Id: <20040202222617.14249C108E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040202213949.30276.qmail@web40408.mail.yahoo.com> you wrote:
>
> I'm using PPCBoot 2.0.0

... which is ancient.

> I have my PPC 750 setup to delay for 5sec then boot
> from the DiskOnChip.  This works properly, as long as
> I have an active serial connection to the board.
> However, I've noticed that if there is not an active
> serial connection to the board, the autoboot function
> will not work.  If I reset the board, with no serial
> connection, then start minicom after 10 seconds I
> always find the following:
>
> => AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
> syntax error

It seems you configured miniom to send a modem init string.  This  is
not expected by PPCBoot.

> Does anyone know what I am doing wrong??

You use minicom.

You post to the wrong list (u-boot-users is a much better  place  for
such questions).

You don't provide any details. Maybe the serial driver on your  board
is waiting for a hardware handshake signal (DCD?) which is down while
disconnected? What happens when you disconnect the cable?

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I see that Microsoft's campaign  to  destroy  all  knowledge  of  any
operating   environment   but  its  own  environment-of-the-year  has
succeeded in creating a generation of users who don't understand  the
concept of a shell...
            -- L. Peter Deutsch in <m0x5jNX-000R2UC@lamp.aladdin.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
