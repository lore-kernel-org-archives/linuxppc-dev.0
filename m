Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 876062BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 02:48:52 +1000 (EST)
Date: Fri, 8 Oct 2004 12:42:00 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041008164047.GC14773@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0410081240240.24432@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 8 Oct 2004, Tom Rini wrote:

> On Fri, Oct 08, 2004 at 07:16:18AM -0400, Robert P. J. Day wrote:
...
>>   in that case, if you wanted to configure "CPM SCC Ethernet", why
>> would you go under "MPC8xx CPM Options" rather than the general
>> networking menu?  this is clearly inconsistent.
>
> Because the CPM1/CPM2 enet drivers are still waiting to be cleaned up a
> bit more, and moved there.  The FEC enet driver that Pantelis wrote
> lives in drivers/net/ for example.

ok, that's cool.

>>   more to the point, i've always found it a bit strange that selecting
>> "8xx" as a processor would suddenly cause the top-level "MPC8xx CPM
>> Options" menu to appear, when other 8xx-related stuff was still
>> scattered elswewhere throughout the kernel source tree.
>
> That's kinda the opposite direction of where I want things to move.
...

i wasn't really arguing for any *particular* rearrangement, just 
arguing for *some* rearrangement that would be more consistent in 
terms of layout, that's all.  and it sounds like it's already 
underway, so i'll shut up about it now.

rday
