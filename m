Return-Path: <nathael.pajani@cpe.fr>
Received: from postfix2-c.free.fr (postfix2-c.free.fr [213.228.0.80])
	by ozlabs.org (Postfix) with ESMTP id 0F4C168705
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 00:14:31 +1100 (EST)
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix2-c.free.fr (Postfix) with ESMTP id D01D013E702A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Nov 2005 13:52:05 +0100 (CET)
Received: from [82.253.211.136] (unknown [82.253.211.136])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C733E372C4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Nov 2005 13:51:57 +0100 (CET)
Message-ID: <437493ED.7090809@cpe.fr>
Date: Fri, 11 Nov 2005 13:51:57 +0100
From: drizzt <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20051111010005.016A868717@ozlabs.org>
In-Reply-To: <20051111010005.016A868717@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: "Now booting the kernel"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> I tried the stuff but I am still getting the same result.
This step can be quite hard to go over... do not deseparate :)

> I did not find the  section "/* 2. Invalidate all entries except the
>  entry we're executing in */" So I commented the TLBWE line in the
> section which says "invalidate all TLB entries " . Is it correct?
I think it is.
Do not forget to uncomment it when you start having outputs.

> The ASM code for rebooting will have to be changed for my board... right?
Yes

On my board, this is a feature of the VME bus, which you should'nt have, 
so check for an instruction or register to perform a reset.


Have fun :) :)
Nathael.
