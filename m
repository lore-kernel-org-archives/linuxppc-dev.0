Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <410DEE94.8030601@intracom.gr>
Date: Mon, 02 Aug 2004 10:34:44 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding parallel port in MPC8245...
References: <20040802072537.86860.qmail@web13604.mail.yahoo.com>
In-Reply-To: <20040802072537.86860.qmail@web13604.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


m madhuker wrote:
> Hello all...
>          Im working on MPC8245 board..
> with timesys GPL-linux..
>
> I want to transfer data(just glow a light) in serial
> port or parallel port...
>
> so i worte a simple program to glow a light in
> parallel port as follows:
>
> ---------
> #include "asm/io.h"
> #include<unistd.h>
> #include<stdlib.h>
> #include<stdio.h>
> main()
> {
>         outb(0x378,0xff);
>         printf("Data sent out \n");
> }
> ----------------------------------------
>
> but when i compiled,it showing errors as follows:
>
> [root@mail root]# powerpc-linux-gcc out.c
> /tmp/ccED5Jlo.o: In function `main':
> /tmp/ccED5Jlo.o(.text+0x20): undefined reference to
> `outb'
> /tmp/ccED5Jlo.o(.text+0x20): relocation truncated to
> fit: R_PPC_REL24 outb
> collect2: ld returned 1 exit status
> [root@mail root]#
> ----------------------------------------
>
> the oub function  defination is in  "asm/io.h"..which
> i included but also it is showing error undefined
> reference...
>
> in x86 it was executed perfectly...
>
> Please can anybody help out from this problem....
>
>                                       Regards
>                                       Madhukar
>
>
>
>

http://www.amazon.com/exec/obidos/tg/detail/-/0764551302/002-9292903-4601667?v=glance


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
