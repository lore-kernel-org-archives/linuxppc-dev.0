Mime-Version: 1.0
Message-Id: <v04220800b4f647bb2f9d@[10.0.0.42]>
In-Reply-To: <200003151243.MAA30200@hyperion.valhalla.net>
References: <200003151243.MAA30200@hyperion.valhalla.net>
Date: Thu, 16 Mar 2000 00:16:48 -0800
To: "Iain Sandoe" <iain@sandoe.co.uk>, Benjamin Herrenschmidt <bh40@calva.net>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Different Mac Models.
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:43 PM +0000 3/15/00, Iain Sandoe wrote:
>>
>>>To nitpick, the chip in question (the PMU) is really a power
>>>management chip which also happens to implement ADB in older models.
>>>
>>>The Sawtooth, iBook, and Pismo all use a new PMU design which is the
>>>first major revision in many years.  It probably doesn't actually
>>>have any pins dedicated to a physical ADB bus anymore, but a virtual
>>>ADB bus implemented in the PMU's firmware is quite possible.
>>
>>  Yes, that's how it's implemented: software emulation of ADB in the PMU.
>>  To my knowledge it's only in the firmware of the iBook and PowerBook PMU,
>>  not in the new iMac nor in the G4 PMU.
>
>firmware as in local (to the PMU) flash/rom...

Firmware local to the PMU.  Previous to the new PMU, the firmware was
in mask ROM, but the new PMU used in Uni-N based systems has flash so
it can be updated.  In both cases the ROM / flash is integrated into
the PMU die, separate from the main system firmware ROM/flash.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
