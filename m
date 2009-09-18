Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ECE30B7B69
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 11:30:28 +1000 (EST)
Date: Thu, 17 Sep 2009 18:30:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: avorontsov@ru.mvista.com
Subject: Re: drivers/mfd/ab3100-core.c
Message-Id: <20090917183019.12f58743.akpm@linux-foundation.org>
In-Reply-To: <20090918012213.GA31463@oksana.dev.rtsoft.ru>
References: <20090917172058.902474da.akpm@linux-foundation.org>
	<20090918012213.GA31463@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sameo@linux.intel.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 18 Sep 2009 05:22:13 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Thu, Sep 17, 2009 at 05:20:58PM -0700, Andrew Morton wrote:
> > This:
> > 
> > static const struct ab3100_init_setting __initdata
> > ab3100_init_settings[] = {
> 
> Looks like it should be __initconst, otherwise it's ambiguous.
> 
> > causes this:
> > 
> > drivers/mfd/ab3100-core.c:651: error: ab3100_init_settings causes a section type conflict
> > 
> > on ppc64.
> > 
> > I keep forgetting why.  Did MFD do something wrong or is powerpc borked
> > or did my compiler version expire?
> 

doh, OK, I forgot about initconst.  I'll try it..
