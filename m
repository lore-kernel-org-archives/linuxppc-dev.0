Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id B955067B28
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:30:36 +1000 (EST)
Message-ID: <42547112.9000302@nortel.com>
Date: Wed, 06 Apr 2005 17:30:26 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <425429BF.1050706@nortel.com> <1112829596.9518.210.camel@gaston>
In-Reply-To: <1112829596.9518.210.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-04-06 at 12:26 -0600, Chris Friesen wrote:
> 
>>I want to retrieve the msr (which is 64-bits) on a 970 when running in 
>>32-bit mode.

> Is this in kernel mode ? Why are you doing that ? 

Yes it is.

We wanted to manipulate the high word of the msr on the 970, from C 
code, while running in 32-bit mode.  I'll be doing something similar to 
get at the high word of HID1 (to enable the en_icbi bit).

Is there some other way to do this?

Chris
