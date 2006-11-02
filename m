Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 80EC567BC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 06:09:33 +1100 (EST)
Message-ID: <454A4266.8040505@ru.mvista.com>
Date: Thu, 02 Nov 2006 22:09:26 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] adding ROM chips to device tree
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
	<1162474237.11351.7.camel@zod.rchland.ibm.com>
In-Reply-To: <1162474237.11351.7.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Vitaly Wool <vwool@ru.mvista.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Josh Boyer wrote:

>>+
>>+    Required properties:
>>+
>>+     - device_type : has to be "rom"

> Why "rom" instead of "NOR"?

    What does "NOR" mean -- logical operator? :-)
    I'd yet agree with "nor-flash", however, the physmap-driven device may not 
always be writeable, IIUC...

>>+     - compatible : Should be the name of the MTD driver. Currently, this is
>>+       most likely to be "physmap".
>>+     - reg : Offset and length of the register set for the device.

> reg doesn't really describe a register set here.  It's the overall
> memory space for flash.

    This is no more a standard boilerplate, if you look at this file.
    Also remember that we're not describing "physmap" compatible devices only.

>>+
>>+    Recommended properties :
>>+
>>+     - bank-width : Width of the flash data bus in bytes. Must be specified
>>+       for the NOR flashes.

> This is a required property, not a recommended one.

    Required by *certain* driver. Others may not need it (know beforehand).

> josh

WBR, Sergei
