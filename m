Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27628DDF94
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 03:26:39 +1000 (EST)
Date: Tue, 26 May 2009 10:26:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: drivers/video/logo/logo_linux_mono.c build error
Message-Id: <20090526102628.8804e281.akpm@linux-foundation.org>
In-Reply-To: <alpine.LRH.2.00.0905261352140.4897@vixen.sonytel.be>
References: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
	<20090428135202.9c9bbadb.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.0904280922410.31001@vixen.sonytel.be>
	<20090513154415.fd10762c.akpm@linux-foundation.org>
	<alpine.LRH.2.00.0905140919230.22602@vixen.sonytel.be>
	<alpine.LRH.2.00.0905261352140.4897@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 May 2009 13:52:34 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> > But logo_linux_mono_data is referenced by 
> > 
> >     const struct linux_logo logo_linux_mono __initconst = { 
> > 	    .type           = LINUX_LOGO_MONO,
> > 	    .width          = 80,
> > 	    .height         = 80,
> > 	    .data           = logo_linux_mono_data
> >     };      
> > 
> > only, which is also __initconst? Where does the section type conflict come
> > from?
> 
> Do you have any follow-up info on this one?

Nope, sorry.  I've been offline for over a week and I only build
powerpc kernels occasionally.

If it's still there, I'll hit it again and I'll take a closer look.
