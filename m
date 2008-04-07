Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3FE7DDE19
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 07:53:22 +1000 (EST)
Date: Mon, 7 Apr 2008 14:53:00 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20080407215300.GA23434@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
	<20080407183817.GB7438@farnsworth.org>
	<7b4fa46820f05cd088680ed3eb521ad6@kernel.crashing.org>
MIME-Version: 1.0
In-Reply-To: <7b4fa46820f05cd088680ed3eb521ad6@kernel.crashing.org>
Subject: Re: [PATCH 1/9 v2] powerpc: change FDT compatible prefix to mrvl
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 10:49:40PM +0200, Segher Boessenkool wrote:
>> Follow the convention that compatible names are prefixed by the
>> vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
>> that's MRVL.
>
>> -		compatible = "marvell,mv64x60";
>> +		compatible = "mrvl,mv64x60";
>
> NAK.
>
> Either use the stock ticker, in UPPER CASE, or use a nice
> descriptive name.  The lower case space is "free for all",
> using shortened names (like "mrvl") there only increases
> the chances of collisions.

[Oops, I forgot to copy the list on my reply to Segher.
Segher, sorry for the repeat.]

Frankly Segher, it doesn't matter to me.  However, NONE of the
existing DTS files use upper-case stock ticker.  I see no reason
to deviate from the existing convention (even if that convention
doesn't follow the previous convention of using upper-case).

Since it seems that the convention for compatible property
prefixes hasn't been decided yet, maybe it would be best for
me to back out this patch and redo those that follow.

I'll do that and repost the series.

-Dale
