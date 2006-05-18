Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74BA5679FC
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 02:41:04 +1000 (EST)
In-Reply-To: <1147936929.17679.106.camel@localhost.localdomain>
References: <9FCDBA58F226D911B202000BDBAD4673062C064E@zch01exm40.ap.freescale.net>
	<1147936929.17679.106.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9D52BC7-8314-42FD-8068-93A91DAD09E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 11:41:17 -0500
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

Get in line ;) [lets be fair, I didn't actually do the 85xx/ads.c  
port, but it was based on the 83xx which I did do]

The problem with the irq mapping is we dont have any code yet that  
handles the "static" tables.

>>> We need a generic add_bridge that goes through PCI bridges and
>>> instanciate based on their type as provided by the device-tree. You
>>> should try to work in that direction...
>
> I suggest you also read my comments to Mark A. Greer as most of that
> stuff overlaps... I wish I had more times to work myself on that  
> but I'm
> fairly overflowed at the moment...
>
> Ben
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
