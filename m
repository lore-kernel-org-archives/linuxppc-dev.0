Message-ID: <3AFF8D0D.FDC7ECD0@folkwang-hochschule.de>
Date: Mon, 14 May 2001 09:45:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFEDE1E.BBB789AC@folkwang-hochschule.de> <20010513205707.32365@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >well, that's just what i'm using.
> >but i have a suse distro (7.1).
> >it works for you ?  no falling asleep, no lockups ?
>
> I never had the falling asleep problem. For some reason, your
> pmud either receives a sleep message from somebody, or incorrectly
> thinks it got one...
>
> I had a few lockups, most related to problems with the kernel
> console code (when sleeping from console). I never had a lockup
> in X but I know that some part of the kernel are quite fragile
> regarding power management (USB for example).
>
> Do you have any other device attached ? (like a PCMCIA card ?)

no.

> >btw, i put the book asleep with snooze -f (circumventing pmud), and
> >it came back without going back to sleep. so yes, the problem seems
> >to be pmud.
>
> You probably need to alter your /etc/pwrctl script, yes. I don't
> have mine at hand right now, I'll send it tomorrow.

thanks a lot for all your help !

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
