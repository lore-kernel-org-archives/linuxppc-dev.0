To: "Dale Farnsworth" <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Nov 2003 12:02:07 MST."
             <20031110190207.GA12163@zenos.farnsworth.org>
Date: Mon, 10 Nov 2003 21:46:47 +0100
Message-Id: <20031110204652.F11E4C5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20031110190207.GA12163@zenos.farnsworth.org> you wrote:
>
> On Fri, Nov 07, 2003 at 10:20:20PM +0000, Wolfgang Denk wrote:
> > The code is actually identical the the later version where Motorola
> > replaced the headers with GPL preambles. I sent a tarball with the GPL
> > bestcomm code to Tom Rini.
>
> I just thought that applying a patch that had "Motorola Confidential
> Proprietary" all over it wasn't a good idea. :-)

You are absolutely right.

> I have merged your code, benh's and mine and placed it at
> ftp://source.mvista.com/pub/linuxppc/mpc5200/linuxppc_2_4_devel.mpc5200.patch
>
> This patch doesn't require uboot.  I retained the uboot code and added
> CONFIG_UBOOT, but haven't tested with it.

I'll look at it ASAP.

> I would appreciate it if you could take some time to test it with your
> hardware.  I find that USB and PCI are not working here, but they also
> fail with your patch, so it may be my icecube hardware.

They are  working  fine  here  (*)  on  three  boards  (2  x  labeled
"IceCube+", 1 x "LITE5200").

(*) - some PCI cards cause problems, for example a 3C905C  card;  I'm
pretty  sure  it  is  a  hardware  issue,  but so far it has not been
confirmed by Motorola yet;  for  USB,  you  may  have  to  short  L15
("below" the USB connector)

> I haven't tested this merged code on the MGT5100, and in fact, I removed
> the MGT5100 FEC support because the #ifdefs in fec.c were just too ugly.
> I'll insert a compatibility layer to support the MGT5100 FEC if there
> is sufficient interest.  Is anyone still using the MGT5100?

Yes, I know of some cases. But too many things are failing on MGT5100
hardware anyway.

> > For me the main issue is that MPC5200 support makes it into the
> > official kernel trees as fast as possible.
>
> Agreed, with reasonable quality.

It has been my impression that the  strategy  is  to  get  things  in
quickly, and to fix them later?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
