From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
Date: Sun, 13 May 2001 22:57:07 +0200
Message-Id: <20010513205707.32365@smtp.wanadoo.fr>
In-Reply-To: <3AFEDE1E.BBB789AC@folkwang-hochschule.de>
References: <3AFEDE1E.BBB789AC@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>well, that's just what i'm using.
>but i have a suse distro (7.1).
>it works for you ?  no falling asleep, no lockups ?

I never had the falling asleep problem. For some reason, your
pmud either receives a sleep message from somebody, or incorrectly
thinks it got one...

I had a few lockups, most related to problems with the kernel
console code (when sleeping from console). I never had a lockup
in X but I know that some part of the kernel are quite fragile
regarding power management (USB for example).

Do you have any other device attached ? (like a PCMCIA card ?)

>are there subtle hardware differences on some pismos ?
>or could it be due to the distro.... pretty unlikely IMHO, given the
>fact that i ditched the SuSE kernel and used yours.
>all i could think of are the card manager and the userland usb
>stuff.
>
>---
>
>btw, i put the book asleep with snooze -f (circumventing pmud), and
>it came back without going back to sleep. so yes, the problem seems
>to be pmud.

You probably need to alter your /etc/pwrctl script, yes. I don't
have mine at hand right now, I'll send it tomorrow.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
