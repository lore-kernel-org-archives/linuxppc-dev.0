Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20030112121009.02d9da10@pop.prodigy.net>
Date: Sun, 12 Jan 2003 12:15:11 -0800
To: Der Herr Hofrat <der.herr@mail.hofr.at>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't
  access tt y; job control turned off
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200301121924.h0CJOr726067@hofr.at>
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC06037@SNCMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:24 AM 1/12/2003, you wrote:
> > I am looking at a ramdisk image ... I am curious if anyone could give me a
> > tip as to why when my bash starts I have no "job contol" (ctrl-z etc)
> ... se
> > below ...
> >
> > BusyBox v0.60.5 (2003.01.09-00:51+0000) Built-in shell (ash)
>
>busybox builtin shell has no job control by default - for ash you have to
>enable it at compile time.

If ash has been built _without_ job control support it will _never_
complain about it,
especially it will never print out that "job control turned off".

If you look at the source code of ash in busybox, you'll see that this
particular message means that shell cannot access controlling tty.


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
