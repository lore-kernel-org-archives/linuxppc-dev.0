Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0071DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 17:27:08 +1100 (EST)
Date: Tue, 3 Feb 2009 22:26:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
Message-Id: <20090203222601.747ca8b7.akpm@linux-foundation.org>
In-Reply-To: <aday6wmn2vr.fsf@cisco.com>
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 03 Feb 2009 22:16:08 -0800 Roland Dreier <rdreier@cisco.com> wrote:

>  > I think it's something like
>  > 
>  > 	huge_page_size(page_hstate(page))
> 
> That would suit.  I assume the intention is for that to be usable by
> driver modules on any architecture?
> 

erm, you overestimate the amount of planning and forethought which goes
into these things ;)

The lack of any EXPORT_SYMBOL(size_to_hstate) is a broadish hint.
