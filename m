Return-Path: <g.jaeger@sysgo.com>
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by ozlabs.org (Postfix) with ESMTP id 997AF2BF10
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2004 00:03:46 +1100 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Nico Schottelius <nico-linux-ppc@schottelius.org>
Date: Thu, 16 Dec 2004 13:18:37 +0100
References: <20041216103325.GA6713@schottelius.org>
In-Reply-To: <20041216103325.GA6713@schottelius.org>
MIME-Version: 1.0
Message-Id: <200412161318.37998.g.jaeger@sysgo.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Error compiling 40x ppc kernels (walnut)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thursday 16 December 2004 11:33, Nico Schottelius wrote:
>I am trying to build a 40x / Walnut Linux (only for testing), but
>the compile process always breaks:
>
>1. walnut build with ibm emac network card enabled
>2. walnut build without ibm emac network card enabled
>
>I am currently using
>
>make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-linux-uclibc-
>
>on my x86 machine as my ibook is currently at home.
>Do you know why those errors occur and can you help me fix them?
>
from what I see from your config file, you have enabled a lot of stuff,
I'm pretty sure which won't build correctly for the walnut.
I.e. the whole framebuffer stuff is not needed - switch it off.
(This is also your problem here!)
I suggest to go through all of your configuration and disable all of
the stuff, which you do not really need:
- frame-buffer
- usb
- all of the crypto stuff
- IPv6
=2E
=2E
=2E

Set at least only processor, platform and serial console support on
(and of course correctly) then try again. Never start with a full=20
or overloaded config set ;)

Ciao,
Gerhard

--=20
Gerhard Jaeger                             g.jaeger@sysgo.com
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
