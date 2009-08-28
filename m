Return-Path: <raj@semihalf.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9C8B1B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 04:30:37 +1000 (EST)
Received: from smtp.semihalf.com (smtp.semihalf.com [213.17.239.109])
	by ozlabs.org (Postfix) with ESMTP id 20016DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 04:30:37 +1000 (EST)
Message-Id: <B7829AEE-B751-403D-9A16-CFE1A4E0FAB0@semihalf.com>
From: Rafal Jaworowski <raj@semihalf.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [RFC] Clock binding
Date: Fri, 28 Aug 2009 20:24:18 +0200
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop>
	<4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop>
	<4A970C85.8090703@firmworks.com>
	<1251420686.20467.96.camel@pasglop>
	<4A974295.9020504@firmworks.com>
	<1251427388.20467.122.camel@pasglop>
	<955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
	<fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Stuart Yoder <stuyoder@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2009-08-28, at 18:06, Grant Likely wrote:

> On Fri, Aug 28, 2009 at 6:16 AM, Stuart Yoder<stuyoder@gmail.com>  
> wrote:
>> On Thu, Aug 27, 2009 at 9:43 PM, Benjamin
>> Herrenschmidt<benh@kernel.crashing.org> wrote:
>>> On Thu, 2009-08-27 at 16:36 -1000, Mitch Bradley wrote:
>>>> The idea of a wiki as a registration authority is a good one, but  
>>>> I'm
>>>> not volunteering to maintain it :-)
>>>
>>> here goes my hope :-)
>>>
>>> Do we have wiki's we could use on power.org or should we aim for a
>>> community place ? Anybody has suggestions ? I wouldn't even try to
>>> maintain a web site myself, that would be irresponsible of anybody  
>>> to
>>> let me do so !
>>
>> There was an ePAPR wiki on power.org, that I had started developing,
>> but it seems to have disappeared.  I'm looking into what happened.
>
> Lets *not* do it on power.org.  I'd like to see the bindings used by
> more than just powerpc people, and power.org might become a bit of a
> mental barrier for non-powerpc folks.  kernel.org would be a good
> host.  So would ozlabs or infradead.  Or I'd be happy to maintain one
> on secretlab.
>
> What about openfirmware.info?  I don't know anything about Core
> Systems who maintains that site though.

Grant,
When choosing the best location for the bindings page please consider  
it uniform enough so that various OSes can use it as a reference. We  
are very much interested in bringing FDT support for embedded FreeBSD  
(arm, powerpc), and one of the uncertainties is how to deal with  
existing Linux bindings definitions: at the moment they are maintained  
as part of kernel source tree, and there are doubts whether we should  
come up with our own set (most likely *very* similar), which we'd like  
to avoid.

Rafal
