Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id C99D6B7D64
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 05:29:55 +1000 (EST)
Received: by wyf28 with SMTP id 28so3150575wyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 12:29:53 -0700 (PDT)
Date: Mon, 26 Apr 2010 23:29:47 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
Message-ID: <20100426192947.GA25762@oksana.dev.rtsoft.ru>
References: <335466.44978.qm@web83505.mail.sp1.yahoo.com>
	<4BD5E940.7000109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4BD5E940.7000109@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Ron Madrid <ron_madrid@sbcglobal.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 26, 2010 at 02:28:00PM -0500, Scott Wood wrote:
> Ron Madrid wrote:
> >Thanks.  Although this doesn't handle programming the
> >UPM, which is where my conflict is occurring.  MDR is
> >used when programming the UPM.  Do you think I would
> >be better served to program the UPM in U-boot and
> >therefore preempt this conflict?
> 
> If you don't need to reprogram it dynamically, doing it either in
> u-boot or early in platform code is probably best.
> 
> I guess the UPM NAND code relies on U-Boot doing this?

Yep, u-boot or platform code.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
