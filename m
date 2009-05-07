Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id F1790DDF82
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 12:42:08 +1000 (EST)
Received: by gxk20 with SMTP id 20so1031193gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 19:42:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-9-git-send-email-wd@denx.de>
	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
	<20090506221908.3927583420E8@gemini.denx.de>
	<fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 20:41:47 -0600
Message-ID: <fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 4:51 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Wed, May 6, 2009 at 4:19 PM, Wolfgang Denk <wd@denx.de> wrote:
>> Dear Grant Likely,
>>
>> In message <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>=
 you wrote:
>>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
>>> > From: Piotr Ziecik <kosmo@semihalf.com>
>>> >
>>> > - Enabled I2C interrupts on MPC5121.
>>> > - Updated Kconfig for i2c-mpc driver.
>>>
>>> I think this workaround belongs in the driver itself.
>>
>> Sorry, I don't get it. Which workaround? What exactly should I change?
>
> Sorry, I misread the patch. =A0Never mind.

Actually, on 3rd reading, I think my first impression was correct
(even if I was wrong about it being a workaround).  This code in
mpc512x_init_i2c() is only relevant for i2c busses (it isn't shared
with any other drivers).  Therefore, it belongs with the i2c bus
itself.  It does not belong in platform code.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
