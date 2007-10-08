Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BEDD2DDF37
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:52:17 +1000 (EST)
In-Reply-To: <fa686aa40710072327j304b7a62q602ed2553787abd4@mail.gmail.com>
References: <47075FA7.3030108@semihalf.com> <4708BFDD.9020900@semihalf.com>
	<fa686aa40710072327j304b7a62q602ed2553787abd4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3BD9DAA1-DBFD-42D7-9F95-57BAA7D28B32@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/15] [POWERPC] TQM5200 DTS
Date: Mon, 8 Oct 2007 08:52:24 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 1:27 AM, Grant Likely wrote:

> On 10/7/07, Marian Balakowicz <m8@semihalf.com> wrote:
>> +
>> +               pci@0d00 {
>> +                       #interrupt-cells = <1>;
>> +                       #size-cells = <2>;
>> +                       #address-cells = <3>;
>> +                       device_type = "pci";
>> +                       compatible = "mpc5200-pci";
>> +                       reg = <d00 100>;
>> +                       interrupt-map-mask = <f800 0 0 7>;
>> +                       interrupt-map = <c000 0 0 1 &mpc5200_pic 0  
>> 0 3
>> +                                        c000 0 0 2 &mpc5200_pic 0  
>> 0 3
>> +                                        c000 0 0 3 &mpc5200_pic 0  
>> 0 3
>> +                                        c000 0 0 4 &mpc5200_pic 0  
>> 0 3>;
>> +                       clock-frequency = <0>; // From boot loader
>> +                       interrupts = <2 8 0 2 9 0 2 a 0>;
>> +                       interrupt-parent = <&mpc5200_pic>;
>> +                       bus-range = <0 0>;
>> +                       ranges = <42000000 0 80000000 80000000 0  
>> 10000000
>> +                                 02000000 0 90000000 90000000 0  
>> 10000000
>> +                                 01000000 0 00000000 a0000000 0  
>> 01000000>;
>> +               };
>
> Also, the PCI node should no longer be a child of the 'soc' node.  See
> the latest lite5200.dts file in Paul Mackerras' powerpc tree for an
> example.

Also, note how the PCI node is a sibling of the soc node not a child  
of it.

- k
