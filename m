Message-Id: <200006261604.SAA26982@denx.local.net>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: "Kwansuk Kim" <kskim@neowave.co.kr>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: omitted kernel sections 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Jun 2000 08:48:36 EDT."
             <4.3.2.20000626080626.00b482e0@falcon.si.com>
Date: Mon, 26 Jun 2000 18:04:57 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.3.2.20000626080626.00b482e0@falcon.si.com> you wrote:
>
> Jon Diekema and I tried Wolfgang's "load" flag hint with the EST JTAG
> debugger and were unsuccessful.  We were unable to use objcopy to make

Well, IMHO the tools should fit the work, no vice  versa.  Maybe  you
can talk with ETS and ask what's necessary to load a Linux image with
their tools.

I don't use EST right now, so I can't help here. I'm using  the  Aba-
tron  box,  and found that Abatron was *very* helpful many times, for
instance by providing a Linux version of their configuration  utility
within  a  few days after I mentioned that I need something like that
(in fact, when I asked for _some_ documentation for the protocol thay
use to access the box, they sent me the full  source  code  of  their
tool). If your tool vendor is no so helpful, you know the options :-)

> Dan Malek has rejected the patch in the BitKeeper tree, although Jon
> and I disagree with him.  I didn't find Dan's reply in the archives, it
> apparently was a direct reply.  His arguments, as I recall (and my
> apologies, Dan, if I get them wrong), are:
>
> * It makes the image larger.
>  > Not really, its just some more elf headers that get stripped on loading.

I'm probably with you here.

> * It isn't how everybody uses the load: everybody just strips the elf
> header (pastes on a proprietary(?) header) and uses it as as a raw
> binary image
>  > I disagree, we ran into the problem, developers before us ran into
> the problem, and it is coming up again.

Here Dan is right, I think. Normally I just strip the ELF header  and
use  the  file as "binary" image - all the tools I'm using can accept
that.

> * It requires an extra relink step.
>  > Not a big deal in my book given the benefits: a valid elf file that
> is loadable by commonly used tools.

Ummm... depends on your definition of "commonly used".

I never needed it myself...

You might also argument that you should be using a firmware which  is
capable of downloading a linux image :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
