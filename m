To: "Steve Rossi" <Steve.Rossi@motorola.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 823 Video Controller Driver - where ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 13 Dec 2002 10:07:31 CST."
             <3DFA05C3.30703@ccrl.mot.com>
Date: Fri, 13 Dec 2002 17:42:43 +0100
Message-Id: <20021213164248.EEFE8C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steve,

in message <3DFA05C3.30703@ccrl.mot.com> you wrote:
>
> I've seen some reference on the list regarding a driver for the 823
> Video Controller -
> i.e.
> http://lists.linuxppc.org/results.html?restrict=linuxppc-embedded&words=vid823
> however I've been unable to locate the source to vid823.c

It is my understanding that this driver is  available  with  and  for
some EP board only, and obviously not available for free.

> apparently this question was asked before:
> http://lists.linuxppc.org/linuxppc-embedded/200201/msg00164.html
> and the answer was that its in the 2_4_devel tree, but I was unable to
> find it in a recent snapshot of the tree (I'm unable to get the tree

I haven't found anything either when I searched some time ago.

> I'm looking for a driver for the video controller to output to an NTSC
> encoder. Am I just missing something?
> Anyone know where I can get vid823.c (or whatever it might be called
> now) and whether its a true framebuffer driver?

We have  a  video  controller  driver  in  our  source  tree  (module
linux-2.4 on our CVS server), see arch/ppc/8xx_io/video823.c

Note: the code relies on some initialization performed by the  U-Boot
boot  loader,  and  it  has  never  been tested yet with NTSC. But it
should be a starting point at least.

And yes, it is a  true  framebuffer  driver,  although  it  uses  the
awkward YUYV video mode format only.

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God may be subtle, but He isn't plain mean.         - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
