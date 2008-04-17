Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3291DE0C1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:54:16 +1000 (EST)
Date: Thu, 17 Apr 2008 13:54:10 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Timur Tabi <timur@freescale.com>
Message-ID: <20080417205410.GA13452@farnsworth.org>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<E1Jmb0q-0003Si-2M@xyzzy.farnsworth.org>
	<4807B7F7.4020209@freescale.com>
MIME-Version: 1.0
In-Reply-To: <4807B7F7.4020209@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 03:49:59PM -0500, Timur Tabi wrote:
> Dale Farnsworth wrote:
> > I find "is_brg" much more meaningful than "clk < QE_CLK1".
> > 
> > Maybe the computer doesn't need it, but it's helpful to a
> > reader of the code.
> 
> That's what comments are for.  I'm all for self-documenting code, but not
> creating additional code to avoid comments.

Well, we disagree then.  Self documenting code of this form is far
preferable to comments that communicate the same thing.

-Dale
