Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BB60EDDFDD
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:36:24 +1000 (EST)
Message-ID: <471E14AD.9090306@ru.mvista.com>
Date: Tue, 23 Oct 2007 19:35:09 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
References: <20071008142658.GA15197@ru.mvista.com>
	<20071023103316.471f8afa@weaponx.rchland.ibm.com>
In-Reply-To: <20071023103316.471f8afa@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Mon, 8 Oct 2007 18:26:58 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> PowerPC 440EPx Sequoia USB OHCI device tree entry.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> I think I saw the OHCI big endian quirk patch go into Linus' tree
> recently.  Is that the only patch this one depends on?
> 

Yes, now we only need a dts entry to enable ohci support for 440EP(x),
Valentine.

> josh
> 
>> ---
>>  arch/powerpc/boot/dts/sequoia.dts |    7 +++++++
>>  1 files changed, 7 insertions(+)
>>
>> diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
>> --- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-10-08 16:29:54.000000000 +0400
>> +++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-10-08 17:56:05.000000000 +0400
>> @@ -122,6 +122,13 @@
>>  			interrupt-map-mask = <ffffffff>;
>>  		};
>>
>> +		USB1: usb@e0000400 {
>> +			compatible = "ohci-be";
>> +			reg = <0 e0000400 60>;
>> +			interrupt-parent = <&UIC0>;
>> +			interrupts = <15 8>;
>> +		};
>> +
>>  		POB0: opb {
>>  		  	compatible = "ibm,opb-440epx", "ibm,opb";
>>  			#address-cells = <1>;
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
