Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4FAADE2E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 01:09:02 +1000 (EST)
Message-ID: <48A59BE3.7000709@freescale.com>
Date: Fri, 15 Aug 2008 10:08:19 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: Linux issues on Xilinx XUPV2P board
References: <20080815143027.BD038B0004C@mail24-sin.bigfish.com>	<48917117000190E8@hawk.dcu.ie>
	<20080815145328.670D4C7004F@mail23-sin.bigfish.com>
In-Reply-To: <20080815145328.670D4C7004F@mail23-sin.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alan.casey5@mail.dcu.ie, wangyanlong <killyouatonce@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Linn wrote:
> Ah I see, sorry about that, misunderstood what was needed.
> 
> So there may be other ways as I'm not a Git expert, but I clone the
> repository, then reset to the a Git tag.
> 
>> git reset --hard <tag name>
> 
> We're working on a new frame buffer driver for a new core, but the old
> frame buffer has not been high priority for us.
> 
> Thanks,
> John 

While this "Works" in the sense that it makes your working
directory look like the contents of the given tag, you are
now using a "detached HEAD" -- ie, no real branch.

If you think you will ever want to make a change or check
in something, you might be better to create a branch based
on the original tag, perhaps something like:

    $ git checkout -b my-v2.6.24 v2.6.24

HTH,
jdl
