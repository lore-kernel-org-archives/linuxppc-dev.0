Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A602DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 16:35:11 +1000 (EST)
In-Reply-To: <20080407210314.GA21993@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
	<20080407183817.GB7438@farnsworth.org>
	<7b4fa46820f05cd088680ed3eb521ad6@kernel.crashing.org>
	<20080407210314.GA21993@farnsworth.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a2c5f83a973abaf04e40cd659e516dba@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/9 v2] powerpc: change FDT compatible prefix to mrvl
Date: Tue, 8 Apr 2008 08:34:47 +0200
To: Dale Farnsworth <dale@farnsworth.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Either use the stock ticker, in UPPER CASE, or use a nice
>> descriptive name.  The lower case space is "free for all",
>> using shortened names (like "mrvl") there only increases
>> the chances of collisions.
>
> Frankly Segher, it doesn't matter to me.  However, NONE of the
> existing DTS files use upper-case stock ticker.  I see no reason
> to deviate from the existing convention

It's not an existing convention, it's a mistake some people made ;-)

> (even if that convention
> doesn't follow the previously defined upper-case stock ticker
> convention.)

That's not a "previously defined convention", it's the defined
rules in the OF standard.  Conventions are examples that are nice
to follow if there's no real reason to choose either way; standards
are things that if you break them, people shout out you.

Let me say this again: it is *fine* if you use some lower-case name.
In that case though, "marvell" is slightly better than "mrvl", and
you had the former already, so just keep it :-)

Agreed?  Ca we move on now?  :-)


Segher
