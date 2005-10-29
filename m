Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 64FE56865C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 11:30:57 +1000 (EST)
Date: Fri, 28 Oct 2005 18:24:13 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051029012413.GA1371@gate.ebshome.net>
References: <200510290046.j9T0ks7c030026@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510290046.j9T0ks7c030026@shell0.pdx.osdl.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: [patch 13/43] Add MAINTAINER entry for the new PowerPC 4xx
	on-chip ethernet controller driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2005 at 05:46:24PM -0700, Andrew Morton wrote:
> 
> From: Eugene Surovegin <ebs@ebshome.net>
> 
> Add MAINTAINER entry for the new PPC4xx EMAC driver

Paul, drop this and the previous patch. They will go in through netdev 
tree and aren't affected by the ppc/ppc64 merge.

-- 
Eugene
