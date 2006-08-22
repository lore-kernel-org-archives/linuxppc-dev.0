Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F19C67BCE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 18:51:04 +1000 (EST)
Message-ID: <44EAC56D.5020508@cambridgebroadband.com>
Date: Tue, 22 Aug 2006 09:50:53 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Phil.Nitschke@avalon.com.au
Subject: Re: ioremap() fails for >64 MB
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
In-Reply-To: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Phil Nitschke wrote:
> Hi all,
> 
> I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
> of it at boot-time, then ioremap() it into the kernel space inside a
> device driver.  So far I've succeeded with 64 MB, but can't go any
> higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
> space - use vmalloc=<size> to increase size."
> 

I remember reading in Linux Device Drivers that you can use the bigphysarea
patch to allocate large memory, as long as you do it at boot time.  It seems
it's been ported to 2.6 too:

	http://lwn.net/Articles/111132/

Alex
