Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 818D3679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 13:24:18 +1000 (EST)
In-Reply-To: <1147936929.17679.106.camel@localhost.localdomain>
References: <9FCDBA58F226D911B202000BDBAD4673062C064E@zch01exm40.ap.freescale.net>
	<1147936929.17679.106.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2800AE5B-623D-4F1A-99A4-A67EF89A0D77@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 15:49:35 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2006, at 02:22, Benjamin Herrenschmidt wrote:

> On Thu, 2006-05-18 at 15:12 +0800, Zang Roy-r61911 wrote:
>>> I'm not repeating Kumar's comments about that CONFIG_7xxx
>>> thing and that
>>> 7xxx/ directory, it should all go.
>>>
>>
>> Should I move my code to embedded6xx?
>
> Probably for now yes.
>
>> I will get rid of those tables.  I can see that in file
>>  arch/powerpc/platforms/85xx/mpc85xx_ads.c (2.6.17-rc4), there is
>> a similar table. Should it be removed in future :)?
>
> Yes. And somebody beaten up for letting that stuff leak into
> arch/powerpc :)
>
>>> Yes, please do so, we will not accept a board that does the above :)
>>
>> I just do the same thing as 85xx :).
>
> Yes and I intend to LART Kumar seriously for that next time I meet
> him :)


So some of this needs to be moved into u-boot (look at my patches to  
u-boot for the 85xx CDS support, and support in the current  
powerpc.git tree).  A lot of the PCI initialization is now there.   
However, the interrupt maps, while properly setup in the current 85xx  
u-boot oftree.dts files, is currently meaningless.  I may be wrong,  
but I thought support for getting the map from the flat-dev tree was  
still pending....
