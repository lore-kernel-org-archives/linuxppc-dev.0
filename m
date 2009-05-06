Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 51E2DDDFB1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:51:47 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so219541yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506221908.3927583420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-9-git-send-email-wd@denx.de>
	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
	<20090506221908.3927583420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:51:26 -0600
Message-ID: <fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com>
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

On Wed, May 6, 2009 at 4:19 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant Likely,
>
> In message <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com> you wrote:
>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
>> > From: Piotr Ziecik <kosmo@semihalf.com>
>> >
>> > - Enabled I2C interrupts on MPC5121.
>> > - Updated Kconfig for i2c-mpc driver.
>>
>> I think this workaround belongs in the driver itself.
>
> Sorry, I don't get it. Which workaround? What exactly should I change?

Sorry, I misread the patch.  Never mind.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
