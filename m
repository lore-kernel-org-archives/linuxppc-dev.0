Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1296BB6F0C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 07:16:20 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAIKC8pC031281
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 15:12:08 -0500
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAIKGGtW080940
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 15:16:17 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAIKHl8A032238
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 13:17:47 -0700
Message-ID: <4B045603.5060801@austin.ibm.com>
Date: Wed, 18 Nov 2009 14:16:03 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/4] Merge OF dynamic patches
References: <4B030FC2.9070401@austin.ibm.com>
	<20091118104147.GD5166@pengutronix.de>
In-Reply-To: <20091118104147.GD5166@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> On Tue, Nov 17, 2009 at 03:04:02PM -0600, Nathan Fontenot wrote:
>> This set of patches merges the common dynamic device tree
>> updating routines of_attach_node() and of_detach_node() to
>> drivers/of/of_dynamic.c.
>>
>> Built and tested on powerpc, I have no access to build/test
>> this on microblaze.
> 
> They look good, but I can't test them as they don't apply to test-devicetree.
> On which commit are they based?

I meant to base these on the test-devicetree branch but it appears that I did
not checkout the test-devicetree branch after cloning.  I will rebase the patches
against the test-devicetree branch and re-send.

> 
> It would be nice if you could also add a diffstat to every patch, this makes
> reviewing 'move-around'-patches a bit easier.

will do.

-Nathan Fontenot
