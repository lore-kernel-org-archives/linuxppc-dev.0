Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 0EEF26881D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 23:56:34 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jAOD4t5R000949
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 15:04:56 +0200 (EET)
Message-ID: <4385B6AD.9060600@intracom.gr>
Date: Thu, 24 Nov 2005 14:48:45 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Clement Fabien <Fabien.Clement@thomson.net>
References: <9C1918067C3BC14C9C351C206D8A843701F7F876@rennsmail03.eu.thmulti.com>
In-Reply-To: <9C1918067C3BC14C9C351C206D8A843701F7F876@rennsmail03.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] CPM2: Fix totally bogus alignment handing of dpalloc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clement Fabien wrote:
> Hi,
> 
> Some results: alignments are now respected but it seems that the method
> I took from linux 2.4 is more efficient in terms of memory consumption.
> I will provide a complete patch today with the same mechanism for
> rh_alloc_fixed.
> 
> Fabien
> 
> 
>

Please don't bother.

The other method messes up the deallocations, you just have to live
with the wasted space.

With rh_alloc_fixed you're suppossed to know your alignment, the align
argument is bogus.

Pantelis
