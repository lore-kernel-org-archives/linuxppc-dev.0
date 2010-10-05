Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AC8EB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 02:18:22 +1100 (EST)
In-Reply-To: <1286266201.2463.336.camel@pasglop>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<1286266201.2463.336.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5EE72F00-BC7C-426B-A828-FE21CC868982@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: use of BAT before taking over the MMU
Date: Tue, 5 Oct 2010 17:22:35 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Cahalan <acahalan@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> The PowerPC OF binding requires the firmware to save and restore
>> the BATs on entry to / exit from the firmware.
>
> I'm not sure he was talking about OF here...

Yeah, I thought I was on a different mailing list.  It's still
sort-of relevant though.

> In any case, we don't muck
> around with BATs until after we're done with OF anyways.

"Lower than the lowest common divider", yeah ;-)


Segher
