Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA4D3679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Feb 2006 18:57:28 +1100 (EST)
Message-ID: <43F97661.6070702@dgt.com.pl>
Date: Mon, 20 Feb 2006 08:57:21 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: arch/ppc/82xx_io/uart.c bug found
References: <43F08EF7.3060109@dgt.com.pl>
	<0744a8b48857d469b3d4ceff6f7fd40f@embeddedalley.com>
In-Reply-To: <0744a8b48857d469b3d4ceff6f7fd40f@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>Three things....
>
>One, this code is obsolete and isn't used any more.
>  
>
It's in latest linuxppc_2_4_devel from denx.de CVS.

>Two, it's not a bug, just a feature enhancement.
>  
>
OK.

>Three, if you want us to actually do something about
>this I need a real patch against an up to date
>public source tree and indication it was actually
>tested on some platform.
>  
>
I'm currently using CVS version from denx.de,
there are lot of features I'm using.

Just use this info as an information, not offcial bug note.
I spend few days finding it.
