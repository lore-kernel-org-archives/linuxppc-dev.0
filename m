Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A95A0DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 09:13:40 +1100 (EST)
In-Reply-To: <ed82fe3e0811071346u291fa477s2147affcc0f8ef42@mail.gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OF36982726.7A11F196-ON882574FA.00798551-882574FA.0079F330@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 7 Nov 2008 14:12:16 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

timur.tabi@gmail.com wrote on 11/07/2008 01:46:42 PM:

> 
> Whether or not using async dma is worth the effort can only be
> determined by profiling the code.  Either it's better, or it's not.
> There's no real way to tell in advance.
> 

Pretty much the answer I expected :), I was just hoping that "wiser and 
more experienced" minds would say "oh, well to do what you want you should 
go in this direction".  Ah well, such is the life of a kernel hacker.

So it sounds like the async dma is the way to go, since I want to off load 
as much as possible from the core.  As you say, though, it's new and not 
in LDD3.  Is .../drivers/dma/dmaengine.c what everyone is refering to as 
async dma?  If not, what is?  And what in the kernel is already using it 
so I can look at some example code.

Thanks very much for the pointers Timur.

Bruce
