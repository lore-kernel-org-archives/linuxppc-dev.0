Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C2D0DDEFB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 08:17:18 +1000 (EST)
Message-Id: <0B7DC24A-2797-42A6-AE94-91C96B336DBA@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080909221321.GA1833@lst.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
Date: Tue, 9 Sep 2008 17:17:05 -0500
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<20080908220349.GD1175@lst.de>
	<10D78C52-1FF1-4944-8689-4404ABE98CA1@freescale.com>
	<20080909204534.GA30975@lst.de> <1220998231.14835.1.camel@pasglop>
	<20080909221321.GA1833@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 9, 2008, at 5:13 PM, Christoph Hellwig wrote:

> On Wed, Sep 10, 2008 at 08:10:31AM +1000, Benjamin Herrenschmidt  
> wrote:
>>
>>> Yeah, the statement this time should be why do you keep _single :)
>>> It don't really mind which one we keep, but having both and both
>>> optional seems rather odd.
>>
>> It would be more logic to implement _single on top of _page.. as  
>> long as
>> we can still do sub-page mappings (needed on ppc64) which I think  
>> we can
>> using the offset / size args of _page...
>>
>> But that means more work changing the existing ppc64 backends :-) So
>> probably a worthwhile long term goal but what Becky did is ok for the
>> transition. I can look at fixing up the ppc64 ones to implement page
>> (and see if that causes any problem) some time after Plumbers conf.
>
> Ok.  But it would be good if we could add comments in the code for the
> to be done later issues we noted so it's harder to forget it.

Will do as I respin.

Thanks!
-Becky
