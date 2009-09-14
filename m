Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4C4F2B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:22:17 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB73CDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:22:16 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8EIHcFP022539
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 12:17:38 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8EIM9db187546
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 12:22:10 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8EIM9nD031248
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 12:22:09 -0600
Message-ID: <4AAE89CE.2030804@austin.ibm.com>
Date: Mon, 14 Sep 2009 13:22:06 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 0/5] kernel handling of dynamic logical partitioning
References: <4AAABC55.4070207@austin.ibm.com>
	<1252704198.28368.31.camel@desktop>
In-Reply-To: <1252704198.28368.31.camel@desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Walker wrote:
> On Fri, 2009-09-11 at 16:08 -0500, Nathan Fontenot wrote:
>>  am cc'ing lkml.
>>
>> Patches include in this set:
>> 1/5 - DLPAR infrastructure for powerpc/pseries platform.
>> 2/5 - Move the of_drconf_cell struct to prom.h
>> 3/5 - Export the memory sysdev class
>> 4/5 - Memory DLPAR handling
>> 5/5 - CPU DLPAR handling
>>
> 
> It looks like a couple of your patches have some checkpatch issues..
> Could you run these through scripts/checkpatch.pl and clean up any
> problems it raises ? Specifically patches 1, 4, and 5 ..
> 

thanks for checking this, I obviously forgot.  I'll post updated patches
(after running checkpatch on them) with fixes.

-Nathan
