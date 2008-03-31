Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4846CDE054
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:34:03 +1000 (EST)
Date: Mon, 31 Mar 2008 09:33:43 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Olof Johansson <olof@lixom.net>
Message-ID: <20080331163343.GB13750@farnsworth.org>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234704.GD30214@farnsworth.org>
	<20080329215753.GA27226@lixom.net>
MIME-Version: 1.0
In-Reply-To: <20080329215753.GA27226@lixom.net>
Subject: Re: [PATCH 4/9] [POWERPC] mv64x60: Fix FDT compatible names:
	mv64x60 => mv64360
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 29, 2008 at 04:57:53PM -0500, Olof Johansson wrote:
> On Fri, Mar 28, 2008 at 04:47:04PM -0700, Dale Farnsworth wrote:
> > From: Mark A. Greer <mgreer@mvista.com>
> > 
> > Compatible names should refer to a specific version of the hardware,
> > without wildcards.  Change each instance of mv64x60 to mv64360, which
> > is the oldest version we currently support.
> 
> Actually, it's normal to have more than one compatible field, from
> specific to generic. So it should make sense to have both (with the
> 64360 entry first).

Sure it's normal to have multiple entries.  But it's not correct to
have names that refer to a range of models, such as mv64x60.  We're
replacing it with a name referring to the oldest specific model, mv64360.
We can add additional entries later if the need arises.

-Dale
