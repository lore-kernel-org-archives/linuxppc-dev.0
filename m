Message-Id: <5.1.0.14.0.20011024100413.02d78e40@pop.gmx.de>
Date: Wed, 24 Oct 2001 10:18:34 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Reducing glibc with mklibs.sh
In-Reply-To: <01101808315200.14753@minotaur.mvista.com>
References: <5.1.0.14.0.20011018123155.026b01c0@pop.gmx.de>
 <20011017123040.23ED310889@denx.denx.de>
 <5.1.0.14.0.20011018123155.026b01c0@pop.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:08 AM 10/18/2001 -0700, Joe Green wrote:
>You have to create them.  This is why the documentation is needed :-).
>The packages come with Hard Hat Linux, but for other distributions you
>need to create them yourself.

Thanks for the quick docu. I could create the optinfo path and it is used
by libopt. But my buildscript fails and I've no idea how to solve it.

I can use mklibs.sh now, so I wait until the docu has been finished.

>   ppc_8xx-libindex -r interp.o sofini.o soinit.o -o <other_objs> > index

I think there was a typo, the library is not specified.
Assuming that other_objs is empty in my case, I've used this command:

ppc_8xx-libindex libc-2.2.2.so -r interp.o sofini.o soinit.o > index


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
