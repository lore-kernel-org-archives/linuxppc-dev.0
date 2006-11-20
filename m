Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 76F6E67B9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 02:28:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Perl 
Date: Mon, 20 Nov 2006 07:28:28 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C0438F3@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C0438F1@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <wd@denx.de>
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

On Monday, November 20, 2006 12:35 AM Wolfgang Denk wrote:
> In message <406A31B117F2734987636D6CCC93EE3C0438F0@ehost011-
> 3.exch011.intermedia.net> you wrote:
>
> > I've done this successfully with ELDK 4.0 and 3.1.1 on PPC440EP
Yosemite
> > board. Resulting perl binary is working with ELDK ppc_4xx filesystem
> > (linux 2.6.13 has been used).
> >=20
> > However it doesn't run on original Yosemite filesystem (I've copied
all
> > perl files there) - it doesn't find certain glibc symbols. With ELDK
4.0

> > tmp # /opt/bin/perl warnings.pl
> > /opt/bin/perl: relocation error: /opt/bin/perl: symbol __floatsidf,
> > version GLIBC_2.3.2 not defined in file libc.so.6 wie

> Looks as if you used the ppc_4xx packages for  this,  which  are  for
> FPU-less  4xx  processors.  On  the  yosemite,  you  should  use  the
> ppc_4xxFP tools instead.
[Leonid] Wee, this really was it, now it works!

Thanks a lot again,

Leonid.
