Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id BBEB2B7BB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 04:03:12 +1100 (EST)
Message-ID: <4AE727CD.3020509@theptrgroup.com>
Date: Tue, 27 Oct 2009 13:03:09 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
MIME-Version: 1.0
To: luigi.mantellini.ml@gmail.com
Subject: Re: Low BogoMips
References: <200910271627.06549.luigi.mantellini.ml@gmail.com>
In-Reply-To: <200910271627.06549.luigi.mantellini.ml@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Luigi 'Comio' Mantellini wrote:
> Hi All,
> 
> my name is Luigi. I'm working on a stripped-down mpc8541 board (that has just 
> a serian and twe enets).
> I have an issue on delay calibration. In fact my at boot time I see the 
> following on the serial console:
> 
> ....
> Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
> ....
> 
> This value seems to be too low and I suspect an error propagated from u-boot.
> 
> Can anyone help me to understand a good way to investigate this problem? which 
> registers or configuration values I need to check?
> 
> I will post the necessary snips of code or configuration if required.
> 
> Thanks a lot for your help,

On the PowerPC, the BogoMIPS is not an estimate of the performance of 
the CPU, but rather related to the internal timebase register frequency.

"With recent kernels, when build with ARCH=powerpc, we now use the
hardware timebase instead of bogus processor loops for short timings.
Thus our bogomips value is no longer the speed at which the processor
runs empty loops, but the actual processor timebase value as obtained
after calibration at boot. " - Benjamin Herrenschmidt

Google(powerpc, bogomips, timebase)=happiness


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
