Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 983ECB70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 05:11:31 +1000 (EST)
Received: by iwn4 with SMTP id 4so1409623iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Sep 2010 12:11:29 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100909184446.GB3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 9 Sep 2010 14:10:59 -0500
Message-ID: <AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 9, 2010 at 1:44 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:

> Single stepping through the initial assembly portion of kernel startup
> shows that the FDT gets clobbered during the function early_init(). This
> trace is reproduced below.

Have you tried also enabling CONFIG_DEBUG_LOCK_ALLOC?  These two
config options are related.

-- 
Timur Tabi
Linux kernel developer at Freescale
