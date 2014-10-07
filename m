Return-Path: <rob@landley.net>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91F031A0A5F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 04:11:07 +1100 (EST)
Received: by mail-oi0-f49.google.com with SMTP id a3so2612821oib.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Oct 2014 10:11:05 -0700 (PDT)
Message-ID: <54341EA2.6010806@landley.net>
Date: Tue, 07 Oct 2014 12:10:58 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-6-git-send-email-linux@roeck-us.net>
 <543412F7.8040909@landley.net> <20141007163131.GE28835@roeck-us.net>
 <54341BF1.9020001@gmail.com>
In-Reply-To: <54341BF1.9020001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Mark Rutland <mark.rutland@arm.com>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
 xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/07/14 11:59, David Daney wrote:
> On 10/07/2014 09:31 AM, Guenter Roeck wrote:
>> On Tue, Oct 07, 2014 at 11:21:11AM -0500, Rob Landley wrote:
>>> On 10/07/14 00:28, Guenter Roeck wrote:
>>>> Devicetree bindings are supposed to be operating system independent
>>>> and should thus not describe how a specific functionality is
>>>> implemented
>>>> in Linux.
>>>
>>> So your argument is that linux/Documentation/devicetree/bindings should
>>> not be specific to Linux. Merely hosted in the Linux kernel source
>>> repository.
>>>
>>> Well that's certainly a point of view.
>>>
>> Not specifically my argument, really, and nothing new either. But,
>> yes, I do
>> think that devicetree bindings descriptions should not include
>> implementation
>> details, especially since those may change over time (as is the case
>> here).
>>
> 
> I fully agree.
> 
> Many device trees come from outside the kernel (i.e. they are supplied
> by the system boot environment).  Obviously these device trees cannot be
> changed at the whim of kernel developers, *and* it is perfectly
> reasonable to think that software other than the Linux kernel will run
> on this type of system too.
> 
> So yes, it is really true, device trees are not a Linux kernel private
> implementation detail, they are really an external ABI that, although
> documented in the kernel source tree, cannot be changed in incompatible
> ways as time progresses.

Ah. Existing thing with backstory among the in-crowd, so I'll assume
"git subtree" was previously suggested and you had that discussion
already and decided against it.

Carry on,

Rob
