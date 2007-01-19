Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 764D9DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 07:04:56 +1100 (EST)
Subject: Re: MPC83xx:  ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
From: Ben Warren <bwarren@qstreams.com>
To: Russell McGuire <rmcguire@uwbt.com>
In-Reply-To: <000801c73c00$01d6cf30$6405a8c0@absolut>
References: <000801c73c00$01d6cf30$6405a8c0@absolut>
Content-Type: text/plain; charset=windows-1251
Date: Fri, 19 Jan 2007 14:58:14 -0500
Message-Id: <1169236694.3029.49.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Russell,

On Fri, 2007-01-19 at 11:28 -0800, Russell McGuire wrote:

> 
> arch/ppc/boot/common/ns16550.c  error: ‘SERIAL_PORT_DFNS’ undeclared
> here ……
> 

I don't think you should be building any code there...  Are you using
ARCH=powerpc (you should be)

regards,
Ben
