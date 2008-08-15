Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE004.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 0A47ADE50E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 00:30:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Linux issues on Xilinx XUPV2P board
Date: Fri, 15 Aug 2008 08:30:25 -0600
In-Reply-To: <4891711700018E59@hawk.dcu.ie>
References: <18997255.post@talk.nabble.com> <4891711700018E59@hawk.dcu.ie>
From: John Linn <John.Linn@xilinx.com>
To: <alan.casey5@mail.dcu.ie>, "wangyanlong" <killyouatonce@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20080815143027.BD038B0004C@mail24-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alan,

I'm assuming you must not have Git installed from the question,
otherwise you would be using git clone as the site shows.

On the http://git.xilinx.com, it says the following, =


Users without Git installed may create a tar file by using the snapshot
feature. Select the tree view of the repository (far right side) on this
page, then select snapshot (near the top) and a gziped tar file will be
created and downloaded. =


Is this what you're looking for?

-- John

> -----Original Message-----
> From: =

> linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org =

> [mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.
> org] On Behalf Of Alan Casey
> Sent: Friday, August 15, 2008 6:34 AM
> To: wangyanlong; linuxppc-embedded@ozlabs.org
> Subject: Re: Linux issues on Xilinx XUPV2P board
> =

> Hi,
> =

>   I used version 2.6.24. Current version is 2.6.26+ but im
>   not sure how to download previous versions from the git
>   tree, there should be some info at http://git.xilinx.com
>   about how to do this.
> =

>   Regards,
>   Alan.
> =

> >-- Original Message --
> >Date: Fri, 15 Aug 2008 04:35:01 -0700 (PDT)
> >From: wangyanlong <killyouatonce@gmail.com>
> >To: linuxppc-embedded@ozlabs.org
> >Subject: Re: Linux issues on Xilinx XUPV2P board
> >
> >
> >
> >Hi Alan =

> >  I dow load the kernel from "
> >http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git
> ;a=3Dsummary
> "
> >
> >Merge ../../linux-2.6 into 2.6.26-merge  master  commit | =

> commitdiff | tree
> >| snapshot
> >  =

> >this version ,but it not work well,which version you downloaded?
> >
> >Many thanks
> >yanlong
> > =

> >
> >Alan Casey wrote:
> >> =

> >> Hi,
> >> =

> >>   Yes i had a problem with using one of the Linux 2.6.26
> >>   kernel versions on the XUPV2P board where the VGA
> >>   display has not driven correctly, not sure why.
> >>   The Linux 2.6.24 kernel from git.xilinx.com works fine.
> >> =

> >>   Regards,
> >>   Alan.
> >>   =

> >> =

> >>>-- Original Message --
> >>>Date: Fri, 15 Aug 2008 01:43:37 -0700 (PDT)
> >>>From: wangyanlong <killyouatonce@gmail.com>
> >>>To: linuxppc-embedded@ozlabs.org
> >>>Subject: Re: Linux issues on Xilinx XUPV2P board
> >>>
> >>>
> >>>
> >>>I meet the problem as yours . And  my vga's display is not =

> clear , have
> >> you
> >>>meet this?
> >>>
> >>>Alan Casey wrote:
> >>>> =

> >>>> Hi,
> >>>> =

> >>>>   I have tried running the Linux 2.6.24 and Linux 2.6.26 =

> kernels from
> >> =

> >>> =

> >>>>   git.xilinx.com on the Xilinx XUPV2P board but have run =

> into a few
> >>>> problems.
> >>>> =

> >>>>   Cross-compiler i use to compile applications was built using
> >>>> Crosstools
> >>>> and
> >>>>   based on gcc 3.3.4. I use Xilinx EDK 7.1 for =

> integrating hardware
> >>>> peripherals
> >>>>   onto the board.
> >>>> =

> >>>>   The problems i've seen are:
> >>>> =

> >>>>   (i) gettimeofday software function returns time of 0 =

> all the time.
> >>>> =

> >>>>   (ii) The Linux 2.6.24 kernel's Xilinx Framebuffer =

> driver and/or the
> >>>> Xilinx
> >>>> 
> >>>>        PLB TFT Controller IP block =

> (plb_tft_cntlr_ref_v1_00_d) does
> not
> >>>> appear
> >>>> =

> >>>>        to centre the display on a VGA screen properly(vertically
> >>>> offset).
> >>>> =

> >>>>   (iii) 64-bit write/read access to peripheral =

> integrated onto the
> >>>> Xilinx
> >>>> =

> >>>>         Virtex-II Pro FPGA either causes a system crash =

> or only lower
> >> part
> >>>> =

> >>>>         of 32-bit data to be written (i.e. lower part of =

> 64-bit data
> >>>> appears
> >>>>         to be mirrored on the upper and lower 32-bits of =

> the system
> >>>> bus).
> >>>>         However, 32-bit write/read access to the =

> peripheral passes as
> >> well
> >>>>         as 64-bit write/read access to the SDRAM memory =

> address space.
> >>>>         Peripheral interface has been verified to be IBM =

> PLB compliant
> >>>
> >>>>         via IBM bus functional model simulations. =

> >>>> =

> >>>>    (iv) The Linux 2.6.26 Xilinx Framebuffer driver on =

> the Xilinx XUPV2P
> >>>> board
> >>>> =

> >>>>         does not appear to be working - nothing displayed to
> >>>> screen/console
> >>>> =

> >>>>         not switching to framebuffer device on bootup. =

> >>>> =

> >>>>    Just wondering if anybody has seen these issues =

> before and know how
> >>>to
> >>>>    resolve them?
> >>>> =

> >>>>    Any info. appreciated,
> >>>>    Regards,
> >>>>    Alan.
> >>>> =

> >>>>   =

> >>>> =

> >>>> =

> >>>> _______________________________________________
> >>>> Linuxppc-embedded mailing list
> >>>> Linuxppc-embedded@ozlabs.org
> >>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>> =

> >>>> =

> >>>
> >>>-- =

> >>>View this message in context:
> >http://www.nabble.com/Linux-issues-on-Xilinx-XUPV2P-board-tp1
> 8262250p18995644.html
> >>>Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> >>>
> >>>_______________________________________________
> >>>Linuxppc-embedded mailing list
> >>>Linuxppc-embedded@ozlabs.org
> >>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >> =

> >> =

> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >> =

> >> =

> >
> >-- =

> >View this message in context: =

> http://www.nabble.com/Linux-issues-on-Xilinx-XUPV2P-board-tp18
> 262250p18997255.html
> >Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> >
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> =

> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> =

> =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
