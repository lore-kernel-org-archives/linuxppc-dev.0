Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83505.mail.sp1.yahoo.com (web83505.mail.sp1.yahoo.com
	[216.252.120.161]) by ozlabs.org (Postfix) with SMTP id B7165B7D43
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 05:24:15 +1000 (EST)
Message-ID: <335466.44978.qm@web83505.mail.sp1.yahoo.com>
Date: Mon, 26 Apr 2010 12:24:14 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4BD5E525.1000406@freescale.com>
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
> Date: Monday, April 26, 2010, 12:10 PM
> Ron Madrid wrote:
> > When you say current UPM code are you talking about
> > fsl_upm.c?  Cause that's only for a NAND device
> on the
> > UPM right?  If there's different code, I don't
> know
> > where it is.
> 
> There's also arch/powerpc/sysdev/fsl_lbc.c

Thanks.  Although this doesn't handle programming the
UPM, which is where my conflict is occurring.  MDR is
used when programming the UPM.  Do you think I would
be better served to program the UPM in U-boot and
therefore preempt this conflict?

Ron
