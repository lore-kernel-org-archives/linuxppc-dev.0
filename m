Message-ID: <C08678384BE7D311B4D70004ACA3710511194633@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Der Herr Hofrat'" <der.herr@mail.hofr.at>, markc@mail.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Control-C in bash ???
Date: Mon, 13 Jan 2003 12:25:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This must be a minicom setting (although I can't find it) --
control-C works fine for me in minicom.

-----Original Message-----
From: Der Herr Hofrat [mailto:der.herr@mail.hofr.at]
Sent: Monday, January 13, 2003 12:20 PM
To: markc@mail.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Control-C in bash ???



>
> On a PC, I can, for instance, enter "ping 192.168.1.4", then hit Control-C
> and stop the ping.  For the life of me, I can't figure out how to do the
> same on my MPC860 system!!!
>
> I have an MPC860 running 2.4.19, with a mostly unmodified eldk
distribution
> from Wolfgang Denx.  I did modify the init script to use /dev/console
instead
> of /ttyx (standard driver using SMC1).  I'd not only like a solution, I
want
> to undertand how cancelling a shell command is supposed to work  - I've
poked
> around and I can't figure out what's supposed to happen - Does the shell
> generate a SIGINT, or the uart driver, or what?  Any enlightenment will be
> greatly appreciated...

I belive that the problem is that the control-C never arives on
the console as the serial-comunication package you are using does
not deliver it (atleast minicom does not) - You can use ping -c 1
(not sure if your ping also takes -c # for the count) to ensure that
it will terminate after one ping package. That was my workaround...

hofrat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
