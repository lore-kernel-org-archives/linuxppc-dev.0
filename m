Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 231EDDF1A8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 03:35:09 +1000 (EST)
Date: Wed, 20 Aug 2008 13:35:00 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
Message-ID: <20080820133500.1b15fb0a@zod.rchland.ibm.com>
In-Reply-To: <ada7iabpptl.fsf@cisco.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
	<fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
	<1219243548.26429.25.camel@jdub.homelinux.org>
	<adak5ebpry5.fsf@cisco.com>
	<20080820131124.05cfee9f@zod.rchland.ibm.com>
	<ada7iabpptl.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Arnd@ozlabs.org, Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 10:19:02 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > Except that logically doesn't make much sense.  Why would you have a
>  > list of mpc52xx and 44x boards together?  They require completely
>  > different kernels because the MMU and drive set is entirely different.
>  > 
>  > Or am I totally missing what you are saying?
> 
> Yeah, I wasn't clear -- I meant to add a new helper like
> of_flat_dt_is_compatible_list() (not sure of the name) that takes a node
> and a NULL-terminated array of strings, and then mpc5200_simple_probe()
> can become a one-liner, along with mpc5121_generic_probe(),
> tqm85xx_probe(), ppc44x_probe(), etc.

Ah, I see.

I worry about doing that though.  I don't want to give people the
impression that these boards are "of" compatible.  I want it to be more
"this file supports these explicit platforms and makes no claim on
compatibility between them".

josh
