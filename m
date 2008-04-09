Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE5A7DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 01:59:34 +1000 (EST)
In-Reply-To: <18428.24729.933714.665889@cargo.ozlabs.ibm.com>
References: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
	<73BD1263-F09B-4E08-AA77-BEBD67D91C58@kernel.crashing.org>
	<1207709608.3996.0.camel@vader.jdub.homelinux.org>
	<18428.24729.933714.665889@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <47ecccf53807a949b54dede883137c6d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 4xx defconfig reorg
Date: Wed, 9 Apr 2008 17:59:17 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I've not heard any objections.  I'll be pushing my commit to my next
>> branch tomorrow morning.
>
> I don't have any objections.  I wonder if Sam Ravnborg responded to
> Segher's patch to extend make help?

I haven't had a reply to that yet, from anyone.  IIRC Sam send a
mail some time ago saying he wouldn't have much time for kbuild
in the future.  I just now see there is a mailing list for kbuild
as well, I'll forward the patch to there.  If nothing happens, can
you pick up the patch?  I've tested it on all architectures that
build on mainline.


Segher
