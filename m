Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 8F284DE083
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:22:35 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so92419anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 15:22:33 -0700 (PDT)
Message-ID: <fa686aa40807161522h6e20eab1m36c4ed55926652b5@mail.gmail.com>
Date: Wed, 16 Jul 2008 16:22:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: [PATCH] Fix wrong 'no interrupt' handling in of_i2c
In-Reply-To: <20080716181556.2974a1a8@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080628183141.15298.2758.stgit@octopus.labnet.pengutronix.de>
	<fa686aa40806281216v71f33a70n67eca1c1e69417d8@mail.gmail.com>
	<20080716181556.2974a1a8@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 4:15 PM, Sean MacLennan <smaclennan@pikatech.com> wrote:
> On Sat, 28 Jun 2008 13:16:16 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>> On Sat, Jun 28, 2008 at 12:31 PM, Wolfram Sang
>> <w.sang@pengutronix.de> wrote:
>> > If an I2C device node does not specify an interrupt, the .irq
>> > member of the board_info struct was set to -1. This caused crashes
>> > on following irq_dispose_mappings. Leave it NO_IRQ as returned from
>> > irq_of_parse_and_map. (Suggesting -1 as 'i2c-no-irq' used to be a
>> > bug in linux/i2c.h.)
>> >
>> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>
> I just hit this while trying to get the at24 driver working. So:
>
> Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Okay, I'll pick this one up.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
