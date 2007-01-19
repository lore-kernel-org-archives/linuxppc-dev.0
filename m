Return-Path: <rmcguire@uwbt.com>
Received: from mail19j.g19.rapidsite.net (mail19j.g19.rapidsite.net
	[204.202.242.58]) by ozlabs.org (Postfix) with SMTP id A793BDDE35
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 07:14:11 +1100 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <bwarren@qstreams.com>
References: <000801c73c00$01d6cf30$6405a8c0@absolut>
	<1169236694.3029.49.camel@saruman.qstreams.net>
Subject: RE: MPC83xx:  ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
Date: Fri, 19 Jan 2007 12:14:04 -0800
Message-ID: <001001c73c06$5fbf2060$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1169236694.3029.49.camel@saruman.qstreams.net>
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

Ben,

That could be the problem

I am building using ARCH=ppc

What is the difference between the two?

-----Original Message-----
From: Ben Warren [mailto:bwarren@qstreams.com] 
Sent: Friday, January 19, 2007 11:58 AM
To: Russell McGuire
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC83xx: ns16550.c - 'SERIAL_PORT_DFNS' undeclared?


Russell,

On Fri, 2007-01-19 at 11:28 -0800, Russell McGuire wrote:

> 
> arch/ppc/boot/common/ns16550.c  error: 'SERIAL_PORT_DFNS' undeclared
> here ..
> 

I don't think you should be building any code there...  Are you using
ARCH=powerpc (you should be)

regards,
Ben
