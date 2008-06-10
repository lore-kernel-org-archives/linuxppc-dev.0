Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B556DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 10:00:18 +1000 (EST)
Date: Mon, 9 Jun 2008 17:00:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [patch 5/5] arch/powerpc/platforms/pseries/eeh_driver.c: fix
	warning
Message-Id: <20080609170012.3225db84.akpm@linux-foundation.org>
In-Reply-To: <1213055222.25745.16.camel@pasglop>
References: <200806092326.m59NQA9c014230@imap1.linux-foundation.org>
	<1213055222.25745.16.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Jun 2008 09:47:02 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2008-06-09 at 16:26 -0700, akpm@linux-foundation.org wrote:
> > From: Andrew Morton <akpm@linux-foundation.org>
> > 
> > Fix this:
> > 
> > /usr/src/devel/arch/powerpc/platforms/pseries/eeh_driver.c: In function 'print_device_node_tree':
> > /usr/src/devel/arch/powerpc/platforms/pseries/eeh_driver.c:55: warning: ISO C90 forbids mixed declarations and code
> > 
> > also make that function look like it's part of Linux.  I mean, wtf are you
> > guys up to down there??
> 
> The EEH code ... oh well. It does need some love...

Feel free to make the changelog more family-friendly.  You can always
tell how many build errors I fixed in the predecing six hours..

> > [akpm@linux-foundation.org: coding-style fixes]
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks.
