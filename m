Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc1-s41.bay0.hotmail.com (bay0-omc1-s41.bay0.hotmail.com
	[65.54.246.113]) by ozlabs.org (Postfix) with ESMTP id 5722EDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 20:35:41 +1100 (EST)
Message-ID: <BAY7-F81C4E9CDFE4D0599271E7BEA90@phx.gbl>
From: "- Reyneke" <reynekejunk@hotmail.com>
To: niklaus.giger@member.fsf.org
Subject: RE: Howto use PPC4xx memory to memory DMA
Date: Fri, 19 Jan 2007 09:35:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ooh - and the 3d thing - cache coherence. I.e.:

	dma_cache_inv((u32)mem, (u32)nBytes);



>>Here are a few things to check:

_________________________________________________________________
Find Love This New Year With match.com! http://msnuk.match.com
