Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56755B6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 08:07:22 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
Date: Tue, 29 May 2012 16:07:16 -0600
In-Reply-To: <4FC50F22.2040404@freescale.com> (Scott Wood's message of "Tue,
 29 May 2012 13:02:10 -0500")
Message-ID: <gvcjetze3.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> CONFIG_MPC831x_RDB doesn't mean that you're running on such a board,
> only that the kernel supports those boards.  It should be a runtime
> test.

Point taken.

If that SATA check is CPU/SOC-based, then it should be easy enough to
test.  The cpuinfo for my board is:

  # cat /proc/cpuinfo
  processor       : 0
  cpu             : e300c3
  clock           : 266.666664MHz
  revision        : 2.0 (pvr 8085 0020)
  bogomips        : 66.66
  timebase        : 33333333

On the other hand, if the problem is actually caused by board trace
routing (or other hardware that's outside the control of the CPU/SOC),
then I don't know how possible a runtime check will be.

Do you know if there is a specific errata that the MPC8315_DS ran
across that required this fix, or was it a band-aid in the first
place?

Either way, thanks for looking into this.

Thanks,
Tony
