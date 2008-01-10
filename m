Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A599DE019
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 04:23:10 +1100 (EST)
Message-ID: <4786546C.7070700@freescale.com>
Date: Thu, 10 Jan 2008 11:22:52 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Return a non-zero exit code if an error occurs	during
	dts parsing.
References: <20080103234333.GC8441@ld0162-tx32.am.freescale.net>
	<20080104043033.GD4326@localhost.localdomain>
	<20080106225509.GC8239@ld0162-tx32.am.freescale.net>
	<20080110035609.GL17816@localhost.localdomain>
In-Reply-To: <20080110035609.GL17816@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Sun, Jan 06, 2008 at 04:55:09PM -0600, Scott Wood wrote:
>> On Fri, Jan 04, 2008 at 03:30:33PM +1100, David Gibson wrote:
>>> This is unequivocally wrong.  boot_info should have information about
>>> the contents of the blob, not state information like the error.
>> "This blob is invalid" *is* information about the contents of the blob.
>>
>>> If you're going to use an ugly global, then use it everywhere.
>> Why go out of our way to make the code even less library-able/thread-safe?
> 
> It doesn't make it any less thread-safe.  A global variable used some
> places is just as bad as a global variable used everywhere from that
> point of view, and is more complicated.

But the knowledge of the fact that the boot_info struct is a global is 
isolated to the treesource code.  I don't see any reason to add another 
global at the *interface* level, much less that not doing so is 
"unequivocally wrong".

-Scott
