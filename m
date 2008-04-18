Return-Path: <benh@ozlabs.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@ozlabs.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080417211905.8ff769fa.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	<20080413171953.bde5e9ac.akpm@linux-foundation.org>
	<1208133506.6958.82.camel@pasglop>
	<20080413191338.9776ebd0.akpm@linux-foundation.org>
	<1208491086.6958.381.camel@pasglop>
	<20080417211905.8ff769fa.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 16:44:21 +1000
Message-Id: <1208501061.6958.394.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-m32r@ml.linux-m32r.org,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > so what
> > about the patch below ?
> 
> I like it, but the compiler won't ;)
> 
> > If you're ok, I'll re-send with appropriate sob
> > & adapted powerpc part.
> 
> Sure.
> 
> > +void __init __attribute__((weak) thread_info_cache_init(void)
> 
> s/weak)/weak))/

Yeah, missing quilt ref :-)

I'll send the proper patches in a minute.

Cheers,
Ben.
