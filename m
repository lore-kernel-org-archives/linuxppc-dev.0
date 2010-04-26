Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83504.mail.sp1.yahoo.com (web83504.mail.sp1.yahoo.com
	[216.252.120.160]) by ozlabs.org (Postfix) with SMTP id DBB32B7D54
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 05:09:00 +1000 (EST)
Message-ID: <479143.77686.qm@web83504.mail.sp1.yahoo.com>
Date: Mon, 26 Apr 2010 12:08:59 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4BD5DCBA.9090304@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: MPC8313: fsl_elbc_nand and MDR
> To: "Ron Madrid" <ron_madrid@sbcglobal.net>
> Cc: linuxppc-dev@ozlabs.org
> Date: Monday, April 26, 2010, 11:34 AM
> Ron Madrid wrote:
> > I am having what appears to be a little conflict
> > with this driver, particularly with the MDR.  My
> > hardware uses NAND flash and an FPGA connected
> > through the UPM.  After the kernel is up and
> > running, sometimes I cannot verify the data in
> > the UPM RAM array.  I am guessing right now that
> > this is due to a use conflict between my
> > application and the fsl_elbc_nand driver both
> > trying to use the MDR at once.
> > 
> > Is there currently any sort of coordination that
> > exists for the MDR in the fsl_elbc_nand driver?
> > I have been looking through the code and have
> > not been able to find any.
> 
> There is not yet any such coordination.  The current
> UPM code does not use MDR that I can see.

When you say current UPM code are you talking about
fsl_upm.c?  Cause that's only for a NAND device on the
UPM right?  If there's different code, I don't know
where it is.

> > Any ideas on how to solve this would be
> > appreciated as well.
> 
> Probably just add a mutex that protects the shared
> resources.

That's what I thought might need to happen.

Ron
