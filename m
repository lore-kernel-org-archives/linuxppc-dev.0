Return-Path: <conn@esteem.com>
Received: from mail.esteem.com (owt-64-146-239-67.owt.com [64.146.239.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1990DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Apr 2007 06:52:33 +1000 (EST)
References: <290919.56258.qm@web43131.mail.sp1.yahoo.com>
In-Reply-To: <290919.56258.qm@web43131.mail.sp1.yahoo.com>
From: "Conn Clark" <clark@esteem.com>
To: patel nirav <indianirav@yahoo.com>
Subject: Re: how to cross compile assembly file for powerpc
Date: Fri, 20 Apr 2007 13:47:27 -0700
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-ID: <courier.462926DF.00005A5D@mail.esteem.com>
Cc: linux ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

patel nirav writes: 

> hello all,
>   I have installed croostool for power pc.
>   Now I created assembly file (.s) with the help of cross compiler.
>   ./powerpc-gcc -S hello.c
>   Now We have hello.s with us. 
>   Now I make changes in the hello.s
>   Now I want to create binary executable of hello.s for PowerPC.
>   So what can I do?
>   Any help will be appreciated.
>    
>   Thanks & Regards
>    
>   Nirav
>   Institute for Plasma Research,
>   India. 
> 

Change the name of hello.s to hello.S
then type 

./powerpc-gcc hello.S 

That should do it. 

Conn 

 ---------------------------------------
Conn Clark 

Electronic Systems Technology
415 N. Quay Street Building B1     (509)-735-9092 ext 117
Kennewick, WA. 99336 

Gentoo Linux RU13$!!!
