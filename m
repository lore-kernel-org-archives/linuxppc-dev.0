Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFE91DDE3F
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 09:47:33 +1000 (EST)
In-Reply-To: <1181954800.26853.103.camel@localhost.localdomain>
References: <20070612163016.253915076@arndb.de>
	<18032.40447.579128.989284@cargo.ozlabs.ibm.com>
	<B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
	<1181954800.26853.103.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AB18F3F9-C844-4ECE-8EE3-7B05DDD5669E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Sat, 16 Jun 2007 18:47:56 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, arnd@arndb.de,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 15, 2007, at 7:46 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2007-06-14 at 08:33 -0500, Kumar Gala wrote:
>> On Jun 13, 2007, at 8:46 PM, Paul Mackerras wrote:
>>
>>> Most of this series of patches touch 8xxx or 5xxx stuff in one  
>>> way or
>>> another, so I'll leave it to Kumar to make the decision about them.
>>> I'll put in 1/13.
>>
>> Arnd,
>>
>> I'm a little hesitant to move the embedded ppc's over to
>> multiplatform quite yet.  One feature I wanted was in Kconfig a way
>> to enforce the selection of at least one choice, as well as being
>> able to optimize things since we only had one choice selected.
>>
>> See the following thread for discussion I had with Sam & Roman on the
>> subject:
>>
>> http://marc.info/?t=117156757000002&r=1&w=2
>
> I missed that discussion... but without actually reading it (yet),  
> I can
> already tell that I don't like the way you propose it. I would much
> prefer the CONFIG_xxx_ONLY_ONE be -generated- by the multiple choice
> menu if only one choice has been selected.
>
> That could be an optional argument to the menu stuff to set that.

That was my intent, that the Kconfig system would help in telling us  
only one choice was selected and we could optimize based on that.  In  
addition, to ensure that at least one choice was selected.  I believe  
Rob Landley came across an issue that exists today with MULTIPLATFORM  
support in that we can attempt to build a kernel w/o any system.

http://marc.info/?t=117529164800005&r=1&w=2

- k
