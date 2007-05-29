Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9832EDE065
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:03:06 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Porting "prep" from ppc to powerpc.
Date: Tue, 29 May 2007 17:02:54 -0400
References: <200705252238.39819.rob@landley.net>
	<20070528075507.GA6633@iram.es>
In-Reply-To: <20070528075507.GA6633@iram.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705291702.55060.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 28 May 2007 3:55 am, Gabriel Paubert wrote:
> On Fri, May 25, 2007 at 10:38:39PM -0400, Rob Landley wrote:
> > Is anyone already doing this?  
> 
> I'm interested but I don't have the time right now.

I'm interested but don't have the expertise.

I don't have prep documentation, I'm not familiar with the internals of the 
powerpc architecture (beyond the endianness/word size/alignment checklist for 
porting userspace programs from arch to arch), I know just enough about Open 
Firmware to really dislike it, and I don't actually have prep hardware.  I do 
have qemu, but it doesn't actually work even with the old ARCH=ppc prep 
kernels.  It segfaults trying to decompress them.

I was hoping to use a prep kernel to debug qemu, but my build system (which 
already builds several other architecutres from the same script) can't do 
ARCH=ppc because that doesn't understand "make headers_install", so I have to 
build them by hand supplying different architectures at different steps of 
the process.  Which puts it waaaaay down on my todo list.

Fixing the Linux build system to actually work for prep would be nice, but it 
sounds like teaching ARCH=ppc to do "make headers install" would be a couple 
orders of magnitude easier...

Rob
