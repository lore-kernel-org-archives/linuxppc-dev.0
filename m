Message-ID: <20040416061853.85230.qmail@web15207.mail.bjs.yahoo.com>
Date: Fri, 16 Apr 2004 14:18:53 +0800 (CST)
From: =?gb2312?q?Song=20Sam?= <samlinuxppc@yahoo.com.cn>
Subject: Re: Any hints on custom keyboard driver?
To: Brad Boyer <flar@allandria.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040415163601.GA19251@pants.nu>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Boyer <flar@allandria.com> wrote:
> > 1. Should I use input.o as interactive interface to communicate with
> > kernel & user space for convenience?

> If you want to use this keyboard for your console, then the easiest
> way would be to create an input layer driver.

Thanks for your hints.So,the data flow related my
custom keyboard driver module could be like this:

My_custom_keyboard device -> mykeyboard.o -> input.o

-> keybdev.o -> LINUX kernel

> I think USB and ADB are the only keyboard drivers using the input
> layer in 2.4, but just about everything is using it in 2.6.

That's also a puzzle for me.Use input layer for my
custom keyboard in 2.4 or not and how?Could I take 2.6
PC keyboard driver as a reference for my custom
keyboard driver?

> > 2. Is there any clue on how to code a standard input driver?Or any
> > reference in this aspect?

> There is some documentation in the kernel source. Take a look at the
> stuff in Documentation/input/.

I have studied some stuff in Documentation/input
several days but still have some troubles for these
simplified demo.Also,I searched "linux keyboard
driver" in google but no luck.Anyway,this is my first
time to code a custom driver.I hope this one isn't
hard more than I can chew.

Thanks a lot for your nice advice!

Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
