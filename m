Message-ID: <20020528113938.19240.qmail@web12702.mail.yahoo.com>
Date: Tue, 28 May 2002 04:39:38 -0700 (PDT)
From: vandana mehtani <vandana_mehtani@yahoo.com>
Subject: Re: boot up sequence 
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020528113337.B6BF511973@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


the one that is defined in boot/head.S..
is it ..
thanks for the information
--- Wolfgang Denk <wd@denx.de> wrote:
> In message
> <20020528112812.32960.qmail@web12707.mail.yahoo.com>
> you wrote:
> >
> > which is the first function that is executed when
> the
> > linux is booted..
>
> The kernel entry point is at _start.
>
> > is it start_kernel or something in head.s..
> > after the lilo  transfers control..
>
> LILO??? On a PowerPC? I don't think so.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> Email: wd@denx.de
> When the bosses talk about improving  productivity,
> they  are  never
> talking about themselves.

Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
