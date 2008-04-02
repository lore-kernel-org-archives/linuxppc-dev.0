Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id B6AB3DE269
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 05:55:07 +1100 (EST)
Date: Wed, 2 Apr 2008 13:54:51 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] RTAS - adapt procfs interface
Message-ID: <20080402185451.GT7137@localdomain>
References: <200804011512.20834.jens@de.ibm.com>
	<20080401163504.GP7137@localdomain> <20080401200404.GS7137@localdomain>
	<18419.29333.344126.231799@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18419.29333.344126.231799@cargo.ozlabs.ibm.com>
Cc: maxim@de.ibm.com, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Nathan Lynch writes:
> 
> > I think this is better... the way these files are used is lame, but
> > this should preserve the existing behavior.  I haven't yet tested
> > this, can you?
> 
> Looks OK -- can I have a proper patch description and a signed-off-by
> line for this please?

Actually, my patch has the potentially undesirable consequence of
allowing only one of the three flash-related proc files to be open at
any time, whereas the previous behavior enforced exclusive open on a
per-file basis.

If you want something for 2.6.25, I think the patch Jens posted is
of lower risk.
