Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D42AEDDE1F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 06:32:43 +1000 (EST)
Date: Sun, 3 May 2009 16:32:41 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: unexpected non-allocatable section
Message-ID: <20090503163241.50bfcae4@lappy.seanm.ca>
In-Reply-To: <20090503200701.GA32601@uranus.ravnborg.org>
References: <20090502224126.641c63bf@lappy.seanm.ca>
	<20090503204546.691ec6e7.sfr@canb.auug.org.au>
	<20090503123959.0cc5c967@lappy.seanm.ca>
	<20090503193316.E72BC83420E8@gemini.denx.de>
	<20090503200701.GA32601@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfgang Denk <wd@denx.de>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 3 May 2009 22:07:01 +0200
"Sam Ravnborg" <sam@ravnborg.org> wrote:

> On Sun, May 03, 2009 at 09:33:16PM +0200, Wolfgang Denk wrote:

> > Which exact commands did you use to build the kenrel, and how did
> > you set (and export?) the CROSS_COMPILE environment variable?

export CROSS_COMPILE=ppc_4xxFP-
export ARCH=powerpc

The toolchain is in my path

> > The thing is, that I cannot reproduce this - I tested it with
> > v2.6.30-rc4, both with ELDK 4.1 (as you) and ELDK 4.2.
> > 
> > Both build the kernel image without any such warnings.
> 
> Anders already found the cause of this - it
> was a missing endian conversion.
> So you need to run this on a little endian target to
> see it. And you need to do a full kernel build
> so we run modpsot on vmlinux.
> 
> I will push the patch in a few minutes.

That patch gets rid of the warnings.

Cheers,
   Sean
