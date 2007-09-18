Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 5707DDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 18:07:49 +1000 (EST)
Message-ID: <46EF8715.4030707@semihalf.com>
Date: Tue, 18 Sep 2007 10:06:45 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Mustafa Cayir <mustafa.cayir@bte.mam.gov.tr>
Subject: Re: Problem booting linux with device tree table
References: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
In-Reply-To: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
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

Mustafa Cayir wrote:
> Hi all,
> 
> I am trying to boot TQM5200 with linux 2.6 kernel. i am using latest
> version of linux and u-boot from denx. And compiled with ELDK4.1
> 
> i use dtc compiler with following command: dtc -O dtb -o tqm5200.dtb
> -b 0 tqm5200.dts

The following switches to dtc taken from
http://www.denx.de/wiki/UBoot/UBootFdtInfo work for me:

dtc -b 0 -V 17 -R 4 -S 0x3000 -I dts -O dtb -f tqm5200.dts > tqm5200.dtb

You might want to try them out, especially the "-S 0x3000".

Regards,
Bartlomiej
