Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 46FBADDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:52:23 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1630890ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 13:52:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1238455136.17330.12.camel@pasglop>
References: <1238383506.17330.0.camel@pasglop>
	<7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
	<20090330135903.GA11614@oksana.dev.rtsoft.ru>
	<1238455136.17330.12.camel@pasglop>
Date: Tue, 31 Mar 2009 14:52:22 -0600
Message-ID: <fa686aa40903311352x1683ab55rada5f77458013864@mail.gmail.com>
Subject: Re: Build error
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 5:18 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2009-03-30 at 17:59 +0400, Anton Vorontsov wrote:
>> On Mon, Mar 30, 2009 at 08:51:38AM -0500, Kumar Gala wrote:
>> >
>> > On Mar 29, 2009, at 10:25 PM, Benjamin Herrenschmidt wrote:
>> >
>> >> My next branch (after merging from you):
>> >>
>> >> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]
>> >> undefined!
>> >>
>> >> I'll ask Linus to pull anyway though.
>> >>
>> >> Cheers,
>> >> Ben.
>> >
>> > I believe this is fixed in net-next (and possible linus has already
>> > pulled that in.)
>>
>> FWIW, I can't reproduce the issue neither in benh/powerpc.git `next'
>> branch nor in `merge' branch...
>
> Ah .. .weird :-)
>
> Oh well, I'll see if it still happens after I pull back from Linus (who
> merged all our stuff) and if it does, I'll send you my .config.

It is triggered when the driver is built as a module.  I'm going to
post the fix right now.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
