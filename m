Return-Path: <torvalds@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D81EB7098
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 06:26:01 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 085D0DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 06:25:59 +1000 (EST)
Date: Sat, 13 Jun 2009 13:25:54 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
In-Reply-To: <alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
Message-ID: <alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sat, 13 Jun 2009, Linus Torvalds wrote:
> 
> On Sat, 13 Jun 2009, Paul Mackerras wrote:
> >
> > Linus, Andrew: OK if this goes in via the powerpc tree?
> 
> Ok by me.

Btw, do 32-bit architectures really necessarily want 64-bit performance 
counters? 

I realize that 32-bit counters will overflow pretty easily, but I do 
wonder about the performance impact of doing things like hashed spinlocks 
for 64-bit counters. Maybe the downsides of 64-bit perf counters on such 
architectures might outweight the upsides?

		Linus
