To: "Dale Farnsworth" <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Nov 2003 16:31:43 MST."
             <20031103233143.GA19177@zenos.farnsworth.org>
Date: Fri, 07 Nov 2003 23:20:20 +0100
Message-Id: <20031107222025.3181CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Dale,

sorry for replying so late, but I was out of office for some days.

In message <20031103233143.GA19177@zenos.farnsworth.org> you wrote:
>
> Thanks for motivating me to action, Wolfgang. :-)

;-)

> The above patch is based on an early, unpublished version of my mpc5200
> port.  While I was quite surprised to find it in Wolfgang's tree, I'm
> confident that Wolfgang received it in good faith.

The code is actually identical the the later version  where  Motorola
replaced  the  headers  with GPL preambles. I sent a tarball with the
GPL bestcomm code to Tom Rini.


> I did not publish the port because the ethernet support relies on a
> Motorola-written DMA subsystem with a proprietary license that doesn't
> permit redistribution.  A month ago, Motorola finally sent me an
> updated, GPLed version of the DMA controller code.  I merged the new
> version, but the DMA API has changed and I've been busy with other things

The main problem with the FEC code  is  that  it  does  NOT  use  the
offical  bestcomm  API but (for efficiency reasons?) meddles directly
with internal bestcomm data. This is why the code  breaks  with  each
new release of the bestcomm code.

> so ethernet isn't quite working again, yet.  I've made several changes
> to the 5200 port as well.
>
> I will post my updated code to this list this week and would prefer
> to see it merged rather than my older code contained in the above patch.

The code I submitted contains some things; some code was developed by
BenH, some by DENX. It would be sad if this stuff was  just  ignored.
How about merging our code and your new stuff?

For me the main issue is that  MPC5200  support  makes  it  into  the
official kernel trees as fast as possible.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have often regretted my speech, never my silence.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
