Return-Path: <sureshtang@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 86342DE01D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 00:00:00 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so982441ugc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jul 2007 06:59:59 -0700 (PDT)
Message-ID: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
Date: Mon, 16 Jul 2007 19:29:59 +0530
From: "suresh suresh" <sureshtang@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kmalloc returns which address
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_40574_9928023.1184594399003"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_40574_9928023.1184594399003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am porting MPC8280 driver from vxWorks to Linux.

I want know the address return by kmalloc function? is it physical address
or kernel virtual address.

For Tx and Rx, hardware uses buffers, so I have to allocate buffers and pass
the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
should convert it into physical address?

If it returns kernel virtual address, then how to convert into physical?

Thanks & Regards-
Suresh

------=_Part_40574_9928023.1184594399003
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>
<br>
I am porting MPC8280 driver from vxWorks to Linux.<br>
<br>
I want know the address return by kmalloc function? is it physical address or kernel virtual address.<br>
<br>
For Tx and Rx, hardware uses buffers, so I have to allocate buffers and
pass the pointer to hardware. Can I pass the pointer returned
kmalloc?&nbsp; or&nbsp; I should convert it into physical address? <br>
<br>
If it returns kernel virtual address, then how to convert into physical?<br>
<br>
Thanks &amp; Regards-<br>
Suresh<br>

------=_Part_40574_9928023.1184594399003--
