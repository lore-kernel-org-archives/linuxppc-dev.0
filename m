Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1DE18DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 02:04:42 +1000 (EST)
In-Reply-To: <20070328083442.GA19500@localhost.localdomain>
References: <boot-3-00.miltonm@bga.com> <boot-3-02.miltonm@bga.com>
	<20070328083442.GA19500@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2939bde6c68ef78c3b249e65f4fb6f40@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/4] bootwrapper: remove unused variable
Date: Wed, 28 Mar 2007 11:04:32 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mar 28, 2007, at 3:34 AM, David Gibson wrote:
> On Wed, Mar 28, 2007 at 02:21:04AM -0600, Milton Miller wrote:
>> gunzip_util.c has a static variable state, obsured in every function
>> by the first passed parameter.  Looks like this got missed in an API
>> change during development.
>
> I think you need to do a new pull.  This one got fixed in the same
> patch that added extra doco about the gunzip functions.

Sorry.  My pull was fine, my selection of relevant patches was
lacking.

I was extracting patches that hit files in boot but not boot/dts
to skip patches that were not boot wrapper related.   However, I
was using the wrong head to list what files are in the boot
directory.  Since it only touched new files, it didn't show up.
After changing to the for-2.6.22 head for the list of files, that
seems to be the only patch I missed.  I'm actually working of
2.6.20 plus the boot patches and the duplicate-reserve and
initrd-reserve patches.

milton
