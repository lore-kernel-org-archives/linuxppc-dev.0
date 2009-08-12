Return-Path: <horms@verge.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE157B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 10:00:38 +1000 (EST)
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id CBA61DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 10:00:38 +1000 (EST)
Date: Thu, 13 Aug 2009 09:26:11 +1000
From: Simon Horman <horms@verge.net.au>
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH 2/2] Support R_PPC64_REL32 relocation type
Message-ID: <20090812232611.GC11982@verge.net.au>
References: <20090810141442.GE3110@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090810141442.GE3110@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, nhorman@redhat.com, kexec@lists.infradead.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2009 at 07:44:42PM +0530, M. Mohan Kumar wrote:
> [PATCH 2/2] Support R_PPC64_REL32 relocation type
> 
> gcc-4.4 compiler creates R_PPC64_REL32 relocation type in the ppc64
> purgatory code. Add support to handle R_PPC64_REL32 relocation type.
> 
> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>

Thanks, applied this one too.
