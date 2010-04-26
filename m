Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83505.mail.sp1.yahoo.com (web83505.mail.sp1.yahoo.com
	[216.252.120.161]) by ozlabs.org (Postfix) with SMTP id 7B3B7B7D16
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 09:46:03 +1000 (EST)
Message-ID: <253970.571.qm@web83505.mail.sp1.yahoo.com>
Date: Mon, 26 Apr 2010 16:46:02 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
To: Scott Wood <scottwood@freescale.com>,
	Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20100426192947.GA25762@oksana.dev.rtsoft.ru>
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

> From: Anton Vorontsov <cbouatmailru@gmail.com>
> Subject: Re: MPC8313: fsl_elbc_nand and MDR
> To: "Scott Wood" <scottwood@freescale.com>
> Cc: linuxppc-dev@ozlabs.org, "Ron Madrid" <ron_madrid@sbcglobal.net>
> Date: Monday, April 26, 2010, 12:29 PM
> On Mon, Apr 26, 2010 at 02:28:00PM
> -0500, Scott Wood wrote:
> > Ron Madrid wrote:
> > >Thanks.  Although this doesn't handle
> programming the
> > >UPM, which is where my conflict is
> occurring.  MDR is
> > >used when programming the UPM.  Do you think
> I would
> > >be better served to program the UPM in U-boot and
> > >therefore preempt this conflict?
> > 
> > If you don't need to reprogram it dynamically, doing
> it either in
> > u-boot or early in platform code is probably best.
> > 
> > I guess the UPM NAND code relies on U-Boot doing
> this?
> 
> Yep, u-boot or platform code.

Thank you both.  This is an easier (and probably better)
solution.

Ron
