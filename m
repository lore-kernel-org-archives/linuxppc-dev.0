Message-ID: <3AFE85F7.1F69E056@folkwang-hochschule.de>
Date: Sun, 13 May 2001 15:02:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFE7826.407D3D0A@folkwang-hochschule.de> <20010513121225.18432@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >when i disable pmud, is there any way to issue sleep requests
> >"natively" to the kernel ?
> >like in /proc/sysctl/ ?
> >
> >i'd rather try that than hacking pmud.
> >
> >what userland programs do you use on your ti book to make it sleep ?
>
> There's a version of snooze that directly sends the proper ioctl
> to /dev/pmu. But you should rather get pmud fixed as it does
> some additional useful things.

ok, to recap this:
sleeping works for you on  a ti powerbook with the same kernel i
use, you are also using pmud
version @(#)$Id: pmud.c,v 1.10 2000/11/21 20:58:32 stephan Exp $,
and you suspect it's pmud that's causing me grief ?

i will use snooze -f for a while to check if that cures it, and
start nagging stephan if it does :)


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
