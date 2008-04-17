Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F351DF7E1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 04:12:06 +1000 (EST)
Date: Thu, 17 Apr 2008 11:11:50 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Sean MacLennan <seanm@seanm.ca>
Message-ID: <20080417181150.GA7139@farnsworth.org>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080413104430.c98244d2.sfr@canb.auug.org.au>
	<20080412215544.38fa2d0b@lappy.seanm.ca>
	<fa686aa40804121909s4ee04731ua63afa76fe088828@mail.gmail.com>
	<E1Jksea-0001ba-DL@xyzzy.farnsworth.org>
	<20080417115045.7e4e6b1e@lappy.seanm.ca>
	<20080417160804.GA696@farnsworth.org>
	<20080417132623.58f8dba7@lappy.seanm.ca>
MIME-Version: 1.0
In-Reply-To: <20080417132623.58f8dba7@lappy.seanm.ca>
Subject: Re: Warp patches for 2.6.26
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

On Thu, Apr 17, 2008 at 01:26:23PM -0400, Sean MacLennan wrote:
> On Thu, 17 Apr 2008 09:08:04 -0700
> "Dale Farnsworth" <dale@farnsworth.org> wrote:
> 
> > I didn't suggest splitting the patches or further modification of the
> > patches themselves.  What I found lacking were the patch descriptions.
> > You need to describe in each patch (commit) commentary exactly what
> > the patch is intended to accomplish, and the rationale behind it.
> 
> Ok, that makes more sense to me. Sorry that I read that wrong :(

No problem.

> One last question.... would the warp_defconfig be considered part of
> the platform code? I think one of the problems was I split up the
> patches when really they all go together (again ignoring led and wdt).
> But I am not sure if the defconfig really goes with the platform code.

I would suggest adding the defconfig as the last patch of the "platform
code" series.  (A separate patch just containing the added defconfig.)

-Dale
