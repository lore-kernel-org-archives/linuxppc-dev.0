Return-Path: <happyphot@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 1E1166886F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 17:36:38 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so39307wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 22:36:34 -0800 (PST)
Message-ID: <005301c60078$b8dd1550$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <hs@denx.de>,
	<linuxppc-embedded@ozlabs.org>
References: <AHEILKONAKAEJPHNMOPNIEDBCEAA.hs@denx.de>
Date: Wed, 14 Dec 2005 14:36:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Subject: Re: MPC8245 with its internal UART
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
  I've tried this (CPC45_config) on Denx Kernel 2.4.25,
and my serial console works now. Thank you very much.

  Is there any similar platform for kernel 2.6 ? (i.e. MPC8245
with its internal UART )

thank you,
/HappyPhot

> 
>> Who can tell me which flatform is similar to mine ? I've tried
>> "make sandpoint_defconfig", but seems not the right one.
> 
> If you want to use Linux 2.4.25, you can try CPC45_defconfig
> from the Denx Kernel ...
