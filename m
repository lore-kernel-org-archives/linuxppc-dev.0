Return-Path: <markn@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4744DDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 23:12:15 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1PCBsfK022043
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 23:11:54 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1PCCWX6467370
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 23:12:32 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1PCCEqY017487
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 23:12:14 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
Date: Wed, 25 Feb 2009 23:13:40 +1100
References: <49A2705D.9030008@in.ibm.com>
	<200902251752.56514.markn@au1.ibm.com> <49A526A6.70509@in.ibm.com>
In-Reply-To: <49A526A6.70509@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902252313.40670.markn@au1.ibm.com>
Cc: Jan Kara <jack@ucw.cz>, Jan Kara <jack@suse.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009 10:08:22 pm Sachin P. Sant wrote:
> Mark Nelson wrote:
> > Hi Sanchin and Geert,
> >
> > Does the patch below fix the problems you're seeing? If it does I'll send
> > a properly written up and formatted patch to linuxppc-dev (as well as
> > another one to fix the same problem in copy_tofrom_user()).
> >   
> This patch fixes the issue at my side. I tried booting the system few times
> and every single time it came up clean.

Good to hear. Thanks for testing Sanchin!

Mark
