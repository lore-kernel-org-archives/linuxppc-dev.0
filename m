From: Benjamin Herrenschmidt <bh40@calva.net>
To: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Thu, 2 Nov 2000 19:09:40 +0100
Message-Id: <19340927114124.27454@192.168.1.2>
In-Reply-To: <3A01882C.9C16CC60@mpifr-bonn.mpg.de>
References: <3A01882C.9C16CC60@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Claus wrote:
>> if you panic'ed with the CD module inserted, would you try to snooze
>without it?
>
>Got it. Without the cd drive module inserted, it does not panic.
>Apparently, it
>is enough that there is a CD drive at all, because there was no CD
inserted or
>mounted. IMHO, this is a serious kernel bug. Anyone out there to fix this?
>
>BTW, in an other approach, I rsync'ed Paul's linux-pmac-stable, but with this
>one the pmud does not start at all as it can not open /dev/adb...

Can you lookup the panic PC, LR and backtrace in your System.map ? Also,
if you could try to figure out what's up with /dev/adb... I suggest
enabling the CONFIG_ALL_PPC (Prep/chrp/pmac). I beleive the problem could
be there. I'll give it a look as soon as I find some time with my linux box.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
