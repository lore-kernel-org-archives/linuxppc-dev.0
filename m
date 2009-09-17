Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB16FB7B74
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Sep 2009 03:57:50 +1000 (EST)
Date: Thu, 17 Sep 2009 13:57:30 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] fix ppc64 build failure on fedora
Message-ID: <20090917175730.GB11961@bombadil.infradead.org>
References: <20090917174144.GA11961@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090917174144.GA11961@bombadil.infradead.org>
Sender: Kyle McMartin <kyle@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2009 at 01:41:44PM -0400, Kyle McMartin wrote:
> For some reason or another (newer gcc?) on Fedora 12 koji builders we're
> seeing _restgpr0_$n symbols instead of _restgpr_$n as handled in the
> prom_init_check.sh file:
> Checking prom_init.o symbol '_restgpr0_14'
> Error: External symbol '_restgpr0_14' referenced from prom_init.c
> Checking prom_init.o symbol '_restgpr0_17'
> 
> Add cases to handle this to the filter portion of the script.
> 

Sorry, after reading the gcc code for this, I've realized this is
clearly wrong and must be a toolchain defect...

Apologies for the noise.

cheers, Kyle
