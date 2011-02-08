Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id BBF2CB712A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 03:59:13 +1100 (EST)
In-Reply-To: <AANLkTin5B02PuVrDH_5FaeYEK+amnopKzS36wyjEafFZ@mail.gmail.com>
References: <OF8C287A2E.13F8CEBF-ON8825782B.0073FBAF-8825782B.00789868@selinc.com>	<20110208021616.GO30616@yookeroo>
	<OF0A8BBBE2.4D143142-ON88257831.000E1C77-88257831.000E6FD6@selinc.com>
	<AANLkTin5B02PuVrDH_5FaeYEK+amnopKzS36wyjEafFZ@mail.gmail.com>
To: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
Subject: Re: Question on supporting multiple HW versions with a single driver
	(warning: long post)
Message-ID: <OF16A0B1B8.4570774F-ON88257831.005D3DDC-88257831.005D4CB8@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 8 Feb 2011 08:59:05 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ah, okay.  Taking a look at that it makes sense now.  Thanks to both of 
you for the help.

Bruce



From:
Bill Gatliff <bgat@billgatliff.com>
To:
Bruce_Leonard@selinc.com
Cc:
David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org
Date:
02/07/2011 09:13 PM
Subject:
Re: Question on supporting multiple HW versions with a single driver 
(warning: long post)



Guys:


I think the Silicon Motion SM501 driver might provide a useful
example, since the chip comes in both memory-mapped and PCI versions.
Unfortunately the chip is implemented as a multi-function driver
(mfd), so the code is not un-complicated.  Still fairly
straightforward and well-written once you learn your way around it,
though.

Basically, it implements a core set of functionality to talk to the
actual chip registers, which is bus-agnostic.  Then the bus-specific
drivers use these functions when they actually want to touch the chip
itself.  In other words, exactly what David suggested.


b.g.


On Mon, Feb 7, 2011 at 8:37 PM,  <Bruce_Leonard@selinc.com> wrote:
>>
>> There are a number of drivers which already have this sort of dual bus
>> binding.
>>
>
> Thanks for the feedback David, I appreciate it.  Could you point me to 
one
> of those drivers that has "this sort of dual bus binding" so can see an
> example of what I'm trying to do?
>
> Bruce
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Bill Gatliff
bgat@billgatliff.com
