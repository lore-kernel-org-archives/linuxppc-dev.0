Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B2E85DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 16:36:57 +1000 (EST)
Message-ID: <4A028182.3040107@grandegger.com>
Date: Thu, 07 May 2009 08:36:50 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
References: <1241640919-4650-1-git-send-email-wd@denx.de>	<1241640919-4650-9-git-send-email-wd@denx.de>
	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
	<20090506221908.3927583420E8@gemini.denx.de>	<fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
In-Reply-To: <fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, May 6, 2009 at 4:51 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Wed, May 6, 2009 at 4:19 PM, Wolfgang Denk <wd@denx.de> wrote:
>>> Dear Grant Likely,
>>>
>>> In message <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com> you wrote:
>>>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
>>>>> From: Piotr Ziecik <kosmo@semihalf.com>
>>>>>
>>>>> - Enabled I2C interrupts on MPC5121.
>>>>> - Updated Kconfig for i2c-mpc driver.
>>>> I think this workaround belongs in the driver itself.
>>> Sorry, I don't get it. Which workaround? What exactly should I change?
>> Sorry, I misread the patch.  Never mind.
> 
> Actually, on 3rd reading, I think my first impression was correct
> (even if I was wrong about it being a workaround).  This code in
> mpc512x_init_i2c() is only relevant for i2c busses (it isn't shared
> with any other drivers).  Therefore, it belongs with the i2c bus
> itself.  It does not belong in platform code.

Right. Furthermore, the i2c-mpc.c should be extened to support bus speed
setting for the MPC512x, which has been merged recently (see commit id
f2bd5efe).

Wolfgang.
