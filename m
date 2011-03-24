Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D5EDB6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 01:34:25 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p2OEYIIn007740
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2011 15:34:19 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: vmsplice bad address
Date: Thu, 24 Mar 2011 15:34:18 +0100
References: <201103031401.55649.dargaud@lpsc.in2p3.fr>
	<1299490544.9759.3.camel@pasglop>
In-Reply-To: <1299490544.9759.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201103241534.18570.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 07 March 2011 10:35:44 Benjamin Herrenschmidt wrote:

> I'm not completely surprised ... I wouldn't expect vmsplice to work
> on /dev/mem ... No struct page backing the memory for example.

So how would that work to do zero-copy ? 
Somebody gave me a hint of marking the memory regions as iomem, do a ioremap then mmap and vmsplice but that's a 
mouthful...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
