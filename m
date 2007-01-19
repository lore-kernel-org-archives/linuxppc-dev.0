Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id C88D4DDE33
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 07:32:42 +1100 (EST)
Subject: RE: MPC83xx:  ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
From: Ben Warren <bwarren@qstreams.com>
To: Russell McGuire <rmcguire@uwbt.com>
In-Reply-To: <001001c73c06$5fbf2060$6405a8c0@absolut>
References: <000801c73c00$01d6cf30$6405a8c0@absolut>
	<1169236694.3029.49.camel@saruman.qstreams.net>
	<001001c73c06$5fbf2060$6405a8c0@absolut>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 15:32:39 -0500
Message-Id: <1169238759.3029.64.camel@saruman.qstreams.net>
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

On Fri, 2007-01-19 at 12:14 -0800, Russell McGuire wrote:
> Ben,
> 
> That could be the problem
> 
> I am building using ARCH=ppc
> 
> What is the difference between the two?
> 
I'm not by any means the expert, but I believe that ARCH=powerpc is a
merge of 32 and 64 bit PowerPC architectures (plus all sorts of
relatives like POWER and cell), and is where 'everybody' is moving.
Many types of processors (including 83xx) have been fully transitioned
to powerpc, while others are in the works.  There are a few differences
that you'd notice, especially the requirement for passing hardware
information via device tree in ARCH=powerpc.  I don't know if ARCH=ppc
is going away for 83xx, but it isn't being maintained or updated, AFAIK.

With ARCH=powerpc, you will hopefully be able to get your board booting
soon, assuming your device tree is correct enough.

regards,
Ben
