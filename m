Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 443AADDEF0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 22:10:03 +1000 (EST)
Date: Tue, 9 Sep 2008 14:09:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: Get USE_STRICT_MM_TYPECHECKS working again
Message-ID: <20080909120956.GA2576@lst.de>
References: <20080909050447.GC30127@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080909050447.GC30127@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 03:04:47PM +1000, David Gibson wrote:
> The typesafe version of the powerpc pagetable handling (with
> USE_STRICT_MM_TYPECHECKS defined) has bitrotted again.  This patch
> makes a bunch of small fixes to get it building again.

It might be a better idea to mark these types __bitwise and use sparse
to do the stricter checking..
