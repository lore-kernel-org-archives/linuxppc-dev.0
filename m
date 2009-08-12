Return-Path: <horms@verge.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EACB9B7B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 10:00:38 +1000 (EST)
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id D59E5DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 10:00:38 +1000 (EST)
Date: Thu, 13 Aug 2009 09:25:47 +1000
From: Simon Horman <horms@verge.net.au>
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
Message-ID: <20090812232547.GB11982@verge.net.au>
References: <20090810141351.GD3110@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090810141351.GD3110@in.ibm.com>
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

On Mon, Aug 10, 2009 at 07:43:51PM +0530, M. Mohan Kumar wrote:
> [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
> 
> kexec is creating a version 3 device tree to be backwards compatible. This
> version of the struct has 8-byte alignment for properties whose value is 8 or
> more bytes. As the code directly checks the pointer when deciding to add the
> alignment word, the struct memory must start on an 8 byte boundary. Force the
> dtstruct variable to be always 8 bytes aligned.
> 
> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>

Thanks, applied.
