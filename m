Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by ozlabs.org (Postfix) with ESMTP id E7BBB67BDF
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 00:28:53 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so295419wri
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 07:28:52 -0700 (PDT)
Message-ID: <a0bc9bf80609290728u776cf110s10ca0688db00ed78@mail.gmail.com>
Date: Fri, 29 Sep 2006 22:28:51 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
In-Reply-To: <9D891AA8-4F40-4FB5-B2CE-2A974FBF4585@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D19D9FB@zch01exm20.fsl.freescale.net>
	<9D891AA8-4F40-4FB5-B2CE-2A974FBF4585@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/29/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Sep 28, 2006, at 10:21 PM, Li Yang-r58472 wrote:
>
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, September 29, 2006 12:37 AM
> >> To: Li Yang-r58472
> >> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org
> >> Subject: Re: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
> >>
> >>
> >> On Sep 28, 2006, at 11:09 AM, Li Yang wrote:
> >>
> >>> On 9/28/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> >>>>
> >>>> On Sep 28, 2006, at 3:18 AM, Li Yang wrote:
> >>>>
> >>>>> Paul,
> >>>>>
> >>>>> The series of patches add generic QE infrastructure called
> >>>>> qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> >>>>> QE device drivers such as ucc_geth driver.
> >>>>>
> >>>>> This version updates QE interrupt controller to use new irq
> >>>>> mapping mechanism, addresses all the comments received with
> >>>>> last submission and includes some style fixes.
> >>>>>
> >>>>> v2 change: Change to use device tree for BCSR and MURAM;
> >>>>> Remove I/O port interrupt handling code as it is not generic
> >>>>> enough.
> >>>>
> >>>> Before accepting any of this code, I'd like to see what the drivers
> >>>> look like that are using it.  Its hard to make significant
> >>>> comments w/
> >>>> o seeing what the consumers of all the 'lib' code look like.
> >>>
> >>> Current in-tree user of the lib is driver/net/ucc_geth.c.  There is
> >>> also QE ATM driver which is included in Alex's 8360sar project.  QE
> >>> USB host/client drivers are in Freescale LTIB BSP.
> >>
> >> is there a serial driver?
> >
> > No.  It is not very necessary to have serial support for QE, as
> > there is
> > separate DUART SoC.  We can use 8250 serial driver for that.
>
> Are there any examples of drivers for a UCC slow channel?

No, at present.
