Message-ID: <3C0DF1A8.934A3588@folkwang-hochschule.de>
Date: Wed, 05 Dec 2001 11:06:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org, DerrikPates <dpates@dsdk12.net>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
References: <3C0D53A4.E6A2F0DD@folkwang-hochschule.de> <20011204231235.7099@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >i'm seeing the same, but on 2.4.16-ben0 on a pismo powerbook.
> >it does not happen every time, but often enough to be almost
> >unusable.
> >
> >i *think* it gets triggered when i hit a button immediately after
> >the screen has blanked. when i wait a couple of seconds until the
> >suspend led has started blinking, i get the machine back most of the
> >time.
> >
> >when it dies, the hd comes up, but the screen remains black. i tried
> >blind-typing "reboot" in a root shell, but nothing happened. i could
> >not ssh into the box from outside. there are no ping echos.
> >
>
> Try the latest rsync and tell me if that still happens.

so far, it has not died after resume. but it only went through 3
sleep cycles so far...
btw, alsa compiles now, the feature.h header is there.

thanks,


jörn


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
