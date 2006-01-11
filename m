Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BB05C689DF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 18:17:15 +1100 (EST)
Date: Tue, 10 Jan 2006 23:10:32 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20060111071032.GA28843@gate.ebshome.net>
References: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
	<17348.37558.434652.697604@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17348.37558.434652.697604@cargo.ozlabs.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, Kumar Gala <galak@gate.crashing.org>,
	sjmunroe@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2006 at 04:08:06PM +1100, Paul Mackerras wrote:
> Oops, I must have sent the wrong version of the patch.  Do we know
> which 440s have or don't have isel?

I checked 44x user manuals I have:

440GP doesn't have isel
440GX, 440EP, 440SP, 440SPe, 440GR have it.

-- 
Eugene
