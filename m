In-Reply-To: <Pine.PMDF.3.96.990117163455.538996255B-100000@uni.edu>
Date: Mon, 18 Jan 1999 00:33:22 +0100
To: puetzk6715@uni.edu
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: wrong termbits.h vs. tty_io.c
Message-Id: <19990118003322.010688@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 17, 1999,  <puetzk6715@uni.edu> wrote:


>Then let's fix it quick (prior to R5-CD freeze).

I've just posted the patch to termios (hand-made, so it may not apply "as
is"). I hope someone will check it in asap.

I've just merged all my patches with Cort's ftp vger image. I've
separated my in-progress DMA code from simple bug fixes, and I hope I'll
be able to submit those before final merge (I lack time, I have a lot of
work and I'll soon be away for one or two weeks). I finally have the
serial driver back to what looks like full functionality on my PowerBook,
I hope I didn't break anything on other machines. There were a couple of
timeouts issues, some bugs with my internal modem FCR bits on PowerBook
G3s, and maybe a couple of other things I fixed by moving code around and
cleaning things up. I've finally made my first successfull PPP connection
with the PB internal modem and it worked great with the serial driver at
115k (looked faster than MacOS PPP). The port should no longer hang when
closed as it used to due to an infinite (almost) timeout in schedule.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
