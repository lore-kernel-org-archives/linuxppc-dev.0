Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72C8EDE100
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:11:54 +1000 (EST)
Message-ID: <49EF5DDF.8050208@freescale.com>
Date: Wed, 22 Apr 2009 13:11:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Subject: Re: ofpart: Partitions at same address cannot have the same name
References: <874owhoxce.fsf@macbook.be.48ers.dk>	<20090422171030.GH14906@codiert.org>
	<49EF5391.9050404@freescale.com>
	<aa76a2be0904221056v7c7357abk52e9b31bb3f7b143@mail.gmail.com>
In-Reply-To: <aa76a2be0904221056v7c7357abk52e9b31bb3f7b143@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David.Woodhouse@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ricardo Ribalda Delgado wrote:
> Hi Scott
> 
>> Perhaps "compatible" should be used instead?
> 
> What do you mean?
> 
> if (strcmp(partname, "partition") || strcmp(partname, "compatible") )
> 
> I can't see the advantages.

No, I mean:

foo {
	compatible = "partition";
	...
};

-Scott
