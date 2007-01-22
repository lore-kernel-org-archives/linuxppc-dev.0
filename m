Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 34E55DDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 04:18:29 +1100 (EST)
Date: Mon, 22 Jan 2007 09:18:27 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: - Reyneke <reynekejunk@hotmail.com>
Subject: Re: Howto use PPC4xx memory to memory DMA
Message-ID: <20070122171827.GB6339@gate.ebshome.net>
References: <Pine.WNT.4.61.0701191344190.2536@holyoke.labs.mot.com>
	<BAY7-F10867A8D2E772EBEFA6A8CBEAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY7-F10867A8D2E772EBEFA6A8CBEAF0@phx.gbl>
Cc: ctz001@email.mot.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Jan 21, 2007 at 09:28:34PM +0000, - Reyneke wrote:
> 
> This seems to be one of those ongoing uncertainties. It seems commonly 
> advocated that you shouldn't use it, but as yet I've found no suitable 
> alternative.

Really?

Could you elaborate, why API described in Documentation/DMA-API.txt 
(e.g. "Streaming DMA mappings") is not suitable for you?.

-- 
Eugene
