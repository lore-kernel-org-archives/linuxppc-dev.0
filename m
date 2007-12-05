Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 56109DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 21:30:04 +1100 (EST)
Message-ID: <47567DB3.8030304@anagramm.de>
Date: Wed, 05 Dec 2007 11:30:11 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474FEE20.6070606@anagramm.de> <47542A50.1030208@anagramm.de>	
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>	
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>	
	<20071203204652.GB4850@loki.buserror.net>	
	<47553D31.4080306@anagramm.de>	
	<20071204130841.GA5765@loki.buserror.net>	
	<4755731D.4050106@anagramm.de>
	<9e4733910712040919v6208c5a3o1afd456c86a37589@mail.gmail.com>
In-Reply-To: <9e4733910712040919v6208c5a3o1afd456c86a37589@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Smirl schrieb:
> On 12/4/07, Clemens Koller <clemens.koller@anagramm.de> wrote:
>> That was discussed already in detail in several threads and there
>> were already decisions made that the DT went into the kernel - no problem
>> with that.
>> I just don't see that it 'really does help' in it's current state if
>> things are broken in a way they are hard to fix for non DT-familiar
>> developers, almost impossible to fix for users which just need to
>> compile their own kernel to achieve their project goal.
>>
>> Well... let's take it easy. I'll dig into the pcf8563 code now.
> 
> Most of this is addressed in the patch series starting with this message:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047382.html
> 
> The pcf8563 driver is converted to the new format and is modified to
> pick up it's address from the device tree.
> 
> This patch series is being held waiting for an ok on the low level
> changes to the i2c subsystem. Hopefully it will go into 2.6.25

Thanks Jon, thanks Scott for the pointers, this works for me.
(Patches have some whitespace damage, you propably want to run
it thru checkpatch.pl before pushing upstream.)

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
