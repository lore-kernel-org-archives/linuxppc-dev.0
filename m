Message-ID: <3AFE7826.407D3D0A@folkwang-hochschule.de>
Date: Sun, 13 May 2001 14:03:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFE70AD.82BA5ED4@folkwang-hochschule.de> <20010513114100.11388@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >ay 14 13:15:01 ephraim pmud[271]: initiating user requested sleep
> >
> >how can i request sleep ? is there some hotkey that i might be
> >triggering ? but then, it seems to happen no matter what i type.
> >
> >May 14 13:15:01 ephraim pmud[271]: running /etc/power/pwrctl sleep
> >battery
> >May 14 13:15:01 ephraim pwrctl: no function for PMU 12
> >May 14 13:15:01 ephraim pmud[271]: going to sleep
>
> Looks like it's pmud who is triggering the sleep request. Looks like
> it thinkgs it got a sleep request from either the "snooze" program,
> Batmon sleep button or whatever...

when i disable pmud, is there any way to issue sleep requests
"natively" to the kernel ?
like in /proc/sysctl/ ?

i'd rather try that than hacking pmud.

what userland programs do you use on your ti book to make it sleep ?



--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
