Message-ID: <3AFEDE1E.BBB789AC@folkwang-hochschule.de>
Date: Sun, 13 May 2001 21:18:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFE85F7.1F69E056@folkwang-hochschule.de> <20010513131352.30216@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >ok, to recap this:
> >sleeping works for you on  a ti powerbook with the same kernel i
> >use, you are also using pmud
> >version @(#)$Id: pmud.c,v 1.10 2000/11/21 20:58:32 stephan Exp $,
> >and you suspect it's pmud that's causing me grief ?
>
> Not exactly. I use pmud 0.7-2 on a Pismo PowerBook (which is approx
> the same motherboard as the TiBook).

well, that's just what i'm using.
but i have a suse distro (7.1).
it works for you ?  no falling asleep, no lockups ?

are there subtle hardware differences on some pismos ?
or could it be due to the distro.... pretty unlikely IMHO, given the
fact that i ditched the SuSE kernel and used yours.
all i could think of are the card manager and the userland usb
stuff.

---

btw, i put the book asleep with snooze -f (circumventing pmud), and
it came back without going back to sleep. so yes, the problem seems
to be pmud.


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
