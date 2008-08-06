Return-Path: <neko@genesi-usa.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.176])
	by ozlabs.org (Postfix) with ESMTP id AE0F5DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 22:22:38 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c21so3981105ika.1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Aug 2008 05:22:35 -0700 (PDT)
Message-ID: <48999787.1060107@genesi-usa.com>
Date: Wed, 06 Aug 2008 13:22:31 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: Quick question about dts
References: <20080805.005649.1713918190.imp@bsdimp.com>
	<489802B3.805@coritel.it>
In-Reply-To: <489802B3.805@coritel.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: "M. Warner Losh" <imp@bsdimp.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Marco Stornelli wrote:
> M. Warner Losh ha scritto:
>> I have a .dts file that works with 2.6.18 (MV Pro 5.0).  I encode it
>> directly into the kernel image.  However, when I try to use it with my
>> 2.6.23, 2.6.24 or 2.6.25 kernel trees, it doesn't work at all.  In the
>> MV Pro 5.0 kernel, I hacked the startup sequence to store a pointer to
>> this blob in r3 so that it is moved in.  I've done something similar
>> in -current (for reasons that are too complicated to really explain
>> well, we can't do this via the normal boot loader mechanisms).  The
>> dtc complains that the interrupt-controller property is obsolete on
>> the chosen device.
>>
>> Does any documentation exist for how dts has evolved?  I'd like to
>> forward port what I have without examining the .dts files from both
>> versions and guessing...
>>
> 
> Check out the kernel documentation booting-without-of.txt of your version.

Better yet, go get the ePAPR specification from Power.org?

It's easier to read :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
