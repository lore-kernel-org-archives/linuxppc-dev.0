Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 9577ADDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 07:17:28 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so79492yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 12:17:27 -0800 (PST)
Message-ID: <fa686aa40811251217g6dcbef77u29e3d6ee6ad6d99f@mail.gmail.com>
Date: Tue, 25 Nov 2008 13:17:26 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <b5e2fc790811251207g38d429f3q4eb698b92162d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<C5518C2F.13137%gerickson@nuovations.com>
	<b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
	<492C573E.9030309@billgatliff.com>
	<b5e2fc790811251207g38d429f3q4eb698b92162d6@mail.gmail.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, Wolfgang Denx <wd@denx.de>,
	linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2008 at 1:07 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>
>
> On Tue, Nov 25, 2008 at 1:51 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
>>
>> Matt Sealey wrote:
>>
>> > I can think of a bunch of reasons why it's a good idea..
>>
>> Can you point to a GPL/LGPL/BSD/etc. source code for an OpenFirmware
>> implementation?
>
> Yes, there's FirmWorks, CodeGen SmartFirmware, IBM SLOF and OpenBIOS..
> they're all linked from the OpenBIOS website (along with a bunch of the
> documentation from http://www.openfirmware.org in more-readable formats like
> PDF)
>
> http://www.openbios.org/
>
>
> But here's the real question; why do you need an opensource implementation?
> Curiosity?

Umm, so that it can be ported to new boards perhaps?  So that
developers can work with it?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
