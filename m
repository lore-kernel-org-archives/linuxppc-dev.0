Subject: Re: Script for RPX Lite DW - Help!!!!
To: jerry.nguyen@serialsystem.com.sg (Nguyen Xuan Hoang)
Date: Fri, 27 Oct 2000 12:03:04 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <01ec01c03fa9$041ce7c0$1f01a8c0@hoangmobile> from "Nguyen Xuan Hoang" at Oct 26, 2000 05:01:11 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20001027010304.551AA209@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nguyen Xuan Hoang writes:
> I am using RPX Lite DW board, unfortunately I did erase the boot code on the
> flash and the board become unusable.
>
> I have an BDM debugger, but don't have the parameter to initialize UPM and
> memory map. So I could not revise the board.

You don't need to initialize the UPM in order to reprogram flash devices via
BDM; you just have to enable the appropriate chip select via the relevant
BRx and ORx register.  Two register writes is all you need (assuming your
BDM already disables the pesky watchdog for you).  What BDM are you using?
Embedded Planet tech support should be able to help you with this sort of
thing.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
