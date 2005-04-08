Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 09ADC67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:48:20 +1000 (EST)
Date: Fri, 8 Apr 2005 11:48:17 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Ho Lee <flylist@linuxkernel.net>
Message-ID: <20050408184816.GA3485@gate.ebshome.net>
References: <F38DEABE0E171746B133C1ABBD142D9703691AFD@radmail.Radstone.Local>
	<013c01c53c63$8b4e98e0$0d02a8c0@acting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <013c01c53c63$8b4e98e0$0d02a8c0@acting>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MTD Mapping driver - out of vmalloc space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 10:51:05AM -0700, Ho Lee wrote:
> 
> Hi Chris,
> 
> How about setting PAGE_OFFSET to 0x80000000, that is 2G/2G split?
> It would make enough virtual address space. I've never tried on PPC,
> so I don't know the side effect of this. 

I successfully use PAGE_OFFSET equal to 0xA000'0000 on 405-based 
designs (2.4 of course :)).

--
Eugene
