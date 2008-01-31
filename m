Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 504B8DDF6F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:55:04 +1100 (EST)
Date: Thu, 31 Jan 2008 13:54:29 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Kernel oops while duming user core.
Message-ID: <20080131195429.GU14201@localdomain>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com>
	<20080131161527.GT14201@localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<504DF4A9-6ED5-4208-84B4-FECC3FC90C0D@kernel.crashing.org>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE4869@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03EE4869@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Kumar Gala wrote:
> > Can you git-bisect to narrow this down further.
> 
> Not easilly, as the board port to arch/powerpc was done on 2.6.24-rc7
> and up.
> Is there an somewhat esy way in git to apply the differences from master
> branch to our board branch to a branch created by bisect?
> 
> And I don't even know where this started to happen.
> Would trying arch/ppc help any? I have our arch/ppc port in a
> semiworking state for kernels up to 2.6.23

Well, we know this happens on other 32-bit powerpc machines (pmac at
least)... perhaps someone could arrange to bisect on a machine that
works with older powerpc kernels (assuming they have a good repro
case).
