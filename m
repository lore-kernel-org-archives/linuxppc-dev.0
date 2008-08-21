Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0272ADDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 04:39:22 +1000 (EST)
Message-ID: <48ADB628.30508@freescale.com>
Date: Thu, 21 Aug 2008 13:38:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: Board support for GE Fanuc SBC610
References: <20080821133852.17201.3862.stgit@welchma.Radstone.Local>	<20080821144144.fed06908.martyn.welch@gefanuc.com>
	<48ADB153.20208@freescale.com>
In-Reply-To: <48ADB153.20208@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Martyn Welch <martyn.welch@gefanuc.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
>> +        mpic: pic@40000 {
>> +            clock-frequency = <0>;
>> +            interrupt-controller;
>> +            #address-cells = <0>;
>> +            #interrupt-cells = <2>;
>> +            reg = <0x00040000 0x00040000>;
>> +            built-in;
>> +            compatible = "chrp,open-pic";
>> +            device_type = "open-pic";
>> +                        big-endian;
> 
> IIRC, we dropped "big-endian" too. (?)

And "built-in".

-Scott
