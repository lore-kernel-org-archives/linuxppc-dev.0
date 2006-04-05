Return-Path: <tnt@246tNt.com>
Received: from outmx014.isp.belgacom.be (outmx014.isp.belgacom.be
	[195.238.4.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49204679EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Apr 2006 09:12:59 +1000 (EST)
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
	by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k35NCinq005537
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Apr 2006 01:12:46 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <44344F50.8010401@246tNt.com>
Date: Thu, 06 Apr 2006 01:14:24 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, idefix@fechner.net
Subject: Re: freescale lite 5200 board and kernel 2.6
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
In-Reply-To: <20060405212741.GC61331@server.idefix.loc>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matthias Fechner wrote:
> Hello Domenico,
>
> * Domenico Andreoli <cavokz@gmail.com> [05-04-06 23:06]:
>   
>> is there any patchset i can use for kernel 2.6? is it production-ready?
>> why isn't already in vanilla 2.6? has any sense to stay with kernel 2.4?
>>     
>
> I'm not sure if this helps, but I was successfully in getting a kernel
> 2.6 running with the icecube board. I have written a short docu in my
> wiki (booting with tftp and rootnfs over NFS):
> http://wiki.idefix.fechner.net/index.php/IceCube#Writing_kernel_modules_for_2.6
>
> Maybe this will help.
> Please give me some feedback.
>   
Nice !

It made me realize the git commands I gave on my website were kinda
wrong, I messed
up git fetch and git pull among other things ...



Sylvain
