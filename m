Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A316DE171
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 06:50:03 +1000 (EST)
In-Reply-To: <20080407183817.GB7438@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
	<20080407183817.GB7438@farnsworth.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7b4fa46820f05cd088680ed3eb521ad6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/9 v2] powerpc: change FDT compatible prefix to mrvl
Date: Mon, 7 Apr 2008 22:49:40 +0200
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Follow the convention that compatible names are prefixed by the
> vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
> that's MRVL.

> -		compatible = "marvell,mv64x60";
> +		compatible = "mrvl,mv64x60";

NAK.

Either use the stock ticker, in UPPER CASE, or use a nice
descriptive name.  The lower case space is "free for all",
using shortened names (like "mrvl") there only increases
the chances of collisions.


Segher
