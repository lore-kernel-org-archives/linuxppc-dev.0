Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DBCD3DE231
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:52:28 +1100 (EST)
Date: Sun, 28 Jan 2007 20:58:44 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: MPIC: support more than 256 sources
Message-ID: <20070129025844.GA6412@lixom.net>
References: <20070125213834.GA22121@lixom.net>
	<1169772540.25005.7.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169772540.25005.7.camel@concordia.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2007 at 11:49:00AM +1100, Michael Ellerman wrote:
> It took me a minute to work out where 2039 and 247 came from, it might
> be clearer as:
[..]

Yep, that's a good idea. Thanks.

> Better still, can you get 255/2047 as (num_sources - 1) or something?

Unfortunately, num_sources has nothing to do with supported vector space,
and it would really have to be num_sources+7, this possibly overrunning
the available range, hardware-wise (instead of just losing the topmost
sources to the software uses).

I'll repost the patch with the change above together with the rest of
the series.


-Olof
