Return-Path: <jhautbois@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id DC726DE152
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 23:06:09 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so435747nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 04:06:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
Date: Fri, 16 Jan 2009 13:06:06 +0100
Message-ID: <8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> try to fix "ft_cpu_setup()" in your u-boot source for mpc8272ads
>> and use "PowerPC,8272@0" as cpu_path instead of "cpu@0".
>>
>> Best regards,
>> Anatolij
>
I am currently going until this step:

## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1505515 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at ff980000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1730966 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02000000
   Booting using the fdt blob at 0x2000000
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 039d7000, end 03b7d996 ... OK
   Loading Device Tree to 007fb000, end 007ff159 ... OK


Could it be a problem in my bootargs command line ?
I mean, maybe the console=ttyS0,11500 wrong ?
Because my "Run" LED is on...

I tried ttyS0, ttyCPM0, tty0.
And I don't have any "Starting kernel..." message.

Thx in advance.
Best Regards,
JM
