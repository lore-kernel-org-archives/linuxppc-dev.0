To: vandana mehtani <vandana_mehtani@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot up sequence 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 May 2002 04:28:12 PDT."
             <20020528112812.32960.qmail@web12707.mail.yahoo.com>
Date: Tue, 28 May 2002 13:33:32 +0200
Message-Id: <20020528113337.B6BF511973@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020528112812.32960.qmail@web12707.mail.yahoo.com> you wrote:
>
> which is the first function that is executed when the
> linux is booted..

The kernel entry point is at _start.

> is it start_kernel or something in head.s..
> after the lilo  transfers control..

LILO??? On a PowerPC? I don't think so.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When the bosses talk about improving  productivity,  they  are  never
talking about themselves.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
