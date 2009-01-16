Return-Path: <jhautbois@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 76A38DDFB5
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 04:44:54 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so474582nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 09:44:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090116172903.GA722@ld0162-tx32.am.freescale.net>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
Date: Fri, 16 Jan 2009 18:44:51 +0100
Message-ID: <8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/1/16 Scott Wood <scottwood@freescale.com>:
> On Fri, Jan 16, 2009 at 01:06:06PM +0100, Jean-Michel Hautbois wrote:
>> Could it be a problem in my bootargs command line ?
>> I mean, maybe the console=3DttyS0,11500 wrong ?
>> Because my "Run" LED is on...
>>
>> I tried ttyS0, ttyCPM0, tty0.
>
> It should be ttyCPM0, or just leave it out and make sure that
> /chosen/linux,stdout-path is set properly.
>
> Have you tried enabling early CPM debugging output?
>
> -Scott
>

Well, I have to say, yes, I tried:
CONFIG_PPC_EARLY_DEBUG_CPM=3Dy
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=3D0xf0001ff8

I have also tried without specifying the console outp=FBt:
setenv bootargs root=3D/dev/ram rw

Nothing more...

JM
