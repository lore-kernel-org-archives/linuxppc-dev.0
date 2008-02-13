Return-Path: <r&d2@dave-tech.it>
Received: from mx.dave-tech.it (mx.dave-tech.it [88.37.112.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "www.qmailtoaster.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D2EE4DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 20:33:03 +1100 (EST)
Message-ID: <47B2B94A.6090600@dave-tech.it>
Date: Wed, 13 Feb 2008 10:32:58 +0100
From: llandre <r&d2@dave-tech.it>
MIME-Version: 1.0
To: mamsadegh@hotmail.com
Subject: V4 FX12 and PLB TEMAC: no space for user logic?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mohammad,

I've just had a look at the messages you generously posted in the ml 
about your experience with linux on V4 FX12 FPGA.
I'd like to ask your opinion about FX12 practical usability in this 
context (gigabit PLB TEMAC/linux).
In this message

http://article.gmane.org/gmane.linux.ports.ppc.embedded/16816

you say the device is completely full. If I understand correctly your 
system provides just the devices required to run the bandwidth test so 
it seems there is no room for user logic (I think you did not even add 
the memory controller required to access the NOR Flash containing 
bootloader, kernel image and root fs that is clearly mandatory for 
standalone product). Is that true? If it is, this limits a lot the 
flexibility of this architecture in this configuration. What do you think?



Regards,
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave.eu
email: r&d2@dave-tech.it
