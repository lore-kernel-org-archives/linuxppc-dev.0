Return-Path: <linuxppcleo@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id 92A6C67BAB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 22:07:44 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t14so202051wxc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 07 Sep 2006 05:07:41 -0700 (PDT)
Message-ID: <a0bc9bf80609070507i411ac4a1t49bcf1bba84f4424@mail.gmail.com>
Date: Thu, 7 Sep 2006 20:07:41 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>
Subject: Re: MPC8360E USB Host Controller Driver
In-Reply-To: <200609071324.30930.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D14C78C@zch01exm20.fsl.freescale.net>
	<200609071324.30930.laurent.pinchart@tbox.biz>
Cc: n.balaji@gdatech.co.in, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/7/06, Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:
> > >    I am working in MPC8360E processor board. I want the
> > > PowerQUICC II's Pro  USB Host controller Driver. In the
> > > manual, they told that this controller does not belong to
> > > UHCI or OHCI standard.
> >
> > Yes, you can call it FHCI if you like. :)
> >
> > >   I have doubt that whether Freescale has its own USB standard.
> >
> > The interface is stated clearly in the UM.
> >
> > >   Please give the link or patch for that driver.
> >
> > There is an 8360 host driver in Freescale LTIB BSP.  Please find it on
> > www.freescale.com, if it has been released.
>
> Could you give a direct link ? I've been browsing around the Freescale website
> for an hour, downloaded hundreds of megabytes of archives but haven't been
> able to find the MPC8360E USB Linux driver.

You can bookmark this link:
http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=0127268688033202A5

- Leo
