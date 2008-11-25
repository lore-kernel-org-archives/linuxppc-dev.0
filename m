Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id DC05DDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 07:23:19 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so80887yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 12:23:18 -0800 (PST)
Message-ID: <fa686aa40811251214w55cb8e60r66702a87f6413a46@mail.gmail.com>
Date: Tue, 25 Nov 2008 13:14:32 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Bill Gatliff" <bgat@billgatliff.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <492C573E.9030309@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<C5518C2F.13137%gerickson@nuovations.com>
	<b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
	<492C573E.9030309@billgatliff.com>
Cc: Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

.  F

On Tue, Nov 25, 2008 at 12:51 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
> Matt Sealey wrote:
>
>> I can think of a bunch of reasons why it's a good idea..
>
> Can you point to a GPL/LGPL/BSD/etc. source code for an OpenFirmware
> implementation?

In powerpc land using the Open Firmware device tree does not depend on
also using Open Firmware.  From that perspective the availability of
an open sourced Open Firmware is irrelevant.

But, both OpenFirmware and SmartFirmware have been open sourced:

http://www.openfirmware.info/Open_Firmware
http://www.openfirmware.info/SmartFirmware

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
