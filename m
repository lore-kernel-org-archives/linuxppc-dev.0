Return-Path: <tiefei.zang@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) by ozlabs.org (Postfix) with ESMTP id 18399B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 19:05:13 +1000 (EST)
Received: by qyk1 with SMTP id 1so1602167qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 02:05:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik6T0GCXwID86fP0DR5GHwrb6F73korUTIItx2M@mail.gmail.com>
References: <1278909366-15903-1-git-send-email-tie-fei.zang@freescale.com>
	<AANLkTikK7wsnSVa9Ww5swaAR828edz_zuiBHzV4WZjqw@mail.gmail.com>
	<AANLkTikv5coqQM4duVmexbOM6iIh-IG-wiCqSqjPHzV3@mail.gmail.com>
	<AANLkTik6T0GCXwID86fP0DR5GHwrb6F73korUTIItx2M@mail.gmail.com>
Date: Mon, 12 Jul 2010 17:05:01 +0800
Message-ID: <AANLkTilRvViceX7sSYNRgAF_Hrzc_uBOAI_g2Q-x2m57@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH v2] rtc: add support for DS3232 RTC
From: Tiefei zang <tiefei.zang@gmail.com>
To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	B11780@freescale.com, Mingkai.hu@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 12, 2010 at 4:30 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> 2010/7/12 Tiefei zang <tiefei.zang@gmail.com>:
>> On Mon, Jul 12, 2010 at 3:08 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
>>> 2010/7/12 Roy Zang <tie-fei.zang@freescale.com>:
>>>> This patch adds the driver for RTC chip DS3232 via I2C bus.
>>>>
>>>
>>> I noted this patch is the second version, maybe you can describe which
>>> modifications you have done here.
>>> and add [PATCH v2] to mail subject.
>> I do not think the modification comparing previous version should go
>> into the commit message.
>> I buy in your comments in original version patch and update:
>> 1. add rtc_valid_tm to check return value.
>> 2. remove ioctl function, which do not used and tested.
>> 3. add __devinit for ds3232 probe
>> 4. put request irq after driver registration.
>>
>
> Okay.
> Which git tree do you want to merge your patch?
I can see you add Andrew in the mail loop.
I think Andrew's test tree should be OK for this patch.
I just updated the patch. So if there is no problem, please pick up the v3:
http://patchwork.ozlabs.org/patch/58584/
Thanks.
Roy
