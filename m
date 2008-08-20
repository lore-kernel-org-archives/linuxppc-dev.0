Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D2653DE33E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 07:15:06 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
	<fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
	<1219243548.26429.25.camel@jdub.homelinux.org>
	<adak5ebpry5.fsf@cisco.com>
	<20080820131124.05cfee9f@zod.rchland.ibm.com>
	<ada7iabpptl.fsf@cisco.com>
	<20080820133500.1b15fb0a@zod.rchland.ibm.com>
Date: Wed, 20 Aug 2008 14:15:02 -0700
In-Reply-To: <20080820133500.1b15fb0a@zod.rchland.ibm.com> (Josh Boyer's
	message of "Wed, 20 Aug 2008 13:35:00 -0400")
Message-ID: <aday72ro0bt.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Arnd@ozlabs.org, Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > Yeah, I wasn't clear -- I meant to add a new helper like
 > > of_flat_dt_is_compatible_list() (not sure of the name) that takes a node
 > > and a NULL-terminated array of strings, and then mpc5200_simple_probe()
 > > can become a one-liner, along with mpc5121_generic_probe(),
 > > tqm85xx_probe(), ppc44x_probe(), etc.

 > I worry about doing that though.  I don't want to give people the
 > impression that these boards are "of" compatible.  I want it to be more
 > "this file supports these explicit platforms and makes no claim on
 > compatibility between them".

It's no big deal really -- just my knee-jerk reaction to seeing a
comment like "this should also be fixed in some other place because I
copied the code from there."  My reaction to that is always, "why not
use one common copy of the code then?"

You could call it something like of_flat_dt_match_list() if that makes
more sense to you.  Or just copy the for loop around, it's not much code.

 - R.
