Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8975FB7B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 05:21:29 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KJHc79030934
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 13:17:38 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KJKufH200166
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 13:20:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KJKtZd022079
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 13:20:55 -0600
Received: from zod.rchland.ibm.com (sig-9-77-145-175.mts.ibm.com
	[9.77.145.175])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n7KJKrLq021811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 13:20:55 -0600
Date: Thu, 20 Aug 2009 15:20:50 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090820192050.GG2530@zod.rchland.ibm.com>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
	<20090730194506.GA30066@linux-wlan.com>
	<20090730200848.GF10244@zod.rchland.ibm.com>
	<20090817151359.GC8710@zod.rchland.ibm.com>
	<20090820174519.GA8860@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090820174519.GA8860@linux-wlan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 20, 2009 at 01:45:19PM -0400, Solomon Peachy wrote:
>On Mon, Aug 17, 2009 at 11:13:59AM -0400, Josh Boyer wrote:
>> >There is another way.  Perhaps you could just copy ppcboot.h to a new file
>> >called "hotfoot.h" and just use that.  It's a duplication of ppcboot.h to
>> >some degree, but it seems to make sense for your board and it helps preserve
>> >the "stock" ppcboot.h for other boards.
>> 
>> Solomon, any update on this?  As far as I'm concerned, the ppcboot.h issue is
>> the only thing that really needs to be reworked before we bring this patch
>> in.
>
>Should I call the new version 'hotfoot.h' or 'ppcboot-hotfoot.h'? 

Either works for me.

josh
