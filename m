Message-ID: <1840.80.7.99.14.1087243664.squirrel@www.solinno.co.uk>
In-Reply-To: <Pine.GSO.4.58.0406142028330.1555@waterleaf.sonytel.be>
References: <1604.80.7.99.14.1087234184.squirrel@www.solinno.co.uk>
    <Pine.GSO.4.58.0406142028330.1555@waterleaf.sonytel.be>
Date: Mon, 14 Jun 2004 21:07:44 +0100 (BST)
Subject: Re: [PATCH][RFC] Make /proc/interrupts show the correct edge/level
     status for PReP machines
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven said:
>> +
>> +		irq_edge_mask = (irq_edge_mask_hi << 8) | irq_edge_mask_lo;
>> +		for (i = 0; i < 16; ++i, irq_edge_mask >> 1)
>                                          ^^^^^^^^^^^^^^^^^^
> Shouldn't that be `irq_edge_mask >>= 1'?

Oops, yes of course.  In fact I was confused how the patch was giving
me the right results at all until I checked the source and found I'd
fixed the error but forgot to update the patch ;-)

Thanks,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
