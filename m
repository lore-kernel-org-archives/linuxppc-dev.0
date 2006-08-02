Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6CB067B90
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 23:35:55 +1000 (EST)
In-Reply-To: <528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: Location for Device Tree Sources?
Date: Wed, 2 Aug 2006 08:35:55 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2006, at 10:20 PM, Grant Likely wrote:

> On 8/1/06, Josh Boyer <jwboyer@jdub.homelinux.org> wrote:
>> On Tue, 2006-08-01 at 17:35 -0700, Mark A. Greer wrote:
>>> On Tue, Aug 01, 2006 at 04:01:33PM -0500, Matthew McClintock wrote:
>>>> On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
>>>>>
>>>>> Mark A. Greer in his patch to port sandpoint to arch/powerpc put
>>>>> sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts
>>>>
>>>> I believe in his latest patches he removed this part. The device  
>>>> trees
>>>> were not included at all and he left this point open for  
>>>> discussion.
>>>
>>> That's correct.
>>>
>>> TBH, I think its wrong to keep them in the kernel source at all-- 
>>> yes,
>>> the same argument could be made for arch/powerpc/boot but that's  
>>> been
>>> settled.
>>
>> Sorry, I have to disagree.  We're talking about device tree _source_
>> files here.  I believe they should be included in the kernel source.
>> Where that is, I don't have a particularly strong argument but they
>> should be included.
>
> I have to second that opinion.  The device tree is absolutely integral
> with the rest of the code/drivers needed to support a board.  I say
> there are stronger arguments for keeping the dts files in the kernel
> source than there are for the boot wrapper.
>
> powerpc/boot/dts makes a lot of sense to me.

I like this location and agree that having them in tree makes sense.   
And putting them under boot isolates them from the kernel proper.

The reason I see to having them in tree is to ensure proper version  
compatibility.  This way there is no concern about which .dts version  
will work with which kernel.  In the future we can always pull them  
out when things are more stable.

- kumar
