Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id D69B967A2C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 02:03:07 +1100 (EST)
Message-ID: <42023D23.6020406@nortel.com>
Date: Thu, 03 Feb 2005 09:02:59 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42011E77.6040906@nortel.com> <1107407613.2363.9.camel@gaston>
In-Reply-To: <1107407613.2363.9.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: new binutils breaks "tlbie" instruction in kernel?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-02-02 at 12:39 -0600, Chris Friesen wrote:
> 
>>The "tlbie" instruction has a bit which may be set to indicate regular 
>>or large page size.  This used to be set via an optional second parameter.
>>
>>Apparently some time between binutils versions 2.15.91.0.2 and 
>>2.15.92.0.2 a change went in to make this second parameter mandatory, 
>>which breaks the kernel ppc code.

> Wasn't it fixed ?

Not sure what "it" you mean.  The current kernel code does not have the 
third parm.  I'm not sure about the latest binutils, but 2.15.92.0.2 is 
what a vendor wants to build on.

Chris
