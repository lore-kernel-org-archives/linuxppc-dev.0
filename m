Message-ID: <3C151A0C.60862796@linux-m68k.org>
Date: Mon, 10 Dec 2001 21:24:44 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: unkillable zombies from using gdb and kernel 2.4.15 and higher?
References: <CF1E527E-ED77-11D5-8C12-0030654D6A26@ivey.uwo.ca> <1008013153.17478.28.camel@pismo>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

"Michel Dänzer" wrote:

> AFAIR zombies have died but are waiting for their return value to be
> read out of the process table. I'd like to know myself how that can
> happen when their parents are gone...

They are reparented to init, which should take care of them.

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
