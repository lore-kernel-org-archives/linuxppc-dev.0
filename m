Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011702b4fefea1120a@[216.164.128.206]>
In-Reply-To: <38D8F9B2.E772CE9@email.sps.mot.com>
References: <Pine.BSF.4.10.10003200951040.10686-100000@invalid.ed.ntnu.no>
Date: Wed, 22 Mar 2000 17:59:15 -0500
To: "Richard Hendricks" <ra6353@email.sps.mot.com>
From: Noah Misch <nmisch@erols.com>
Subject: Re: What is the catch with IDMA on MPC860?
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Would you mind telling me briefly what CPM, UART, DMA/IDMA, UPM, and SCC
are, or pointing me to a document that explains them?  I see these terms
used a lot, but I don't know what they stand for and have only a general
idea of what they are.  I apologize for wasting your time with a worthless
question.

<snip>

>Just be sure you don't overtax your CPM.  20/27.45 = 73%,
>but if you start adding in UARTs, etc, you might be getting
>close to the edge.

<snip>

>> I can live with the fact that IDMA can not utilize the
>> bus 100% of the time as long as it __relinquish the bus__
>> at all times it does not perform __full speed__ data
>> movements. Actually I prefer it does just that.

<snip

>> > Er, you're doing DMA to/from a memory.  The timing of that
>> > memory controls /TA.  If you're using your DRAM with one
>> > of the UPMs, and you're targeting that DRAM with IDMA, it
>> > uses the UPM to control the DRAM. (For a flyby-mode transaction).

<snip>
Noah Misch
nmisch@erols.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
