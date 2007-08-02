Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 064ECDDDD5
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 09:56:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72NuGq8010968
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 19:56:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72NuGq8111652
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 17:56:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72NuGnA004638
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 17:56:16 -0600
Subject: Re: [PATCH] Use 1TB segments
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1186094245.5495.637.camel@localhost.localdomain>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1186087283.22717.80.camel@farscape.rchland.ibm.com>
	<1186094245.5495.637.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 18:56:14 -0500
Message-Id: <1186098974.22717.86.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 08:37 +1000, Benjamin Herrenschmidt wrote:
> > Is there technical reason why the 'local' variable remains at the end of
> > the parm list for these?   In other cases 'ssize' simply gets added to
> > the end of the parm list. 
> 
> Looks nicer to have psize and ssize together :-)

Aah!   And here I thought there was some obscure register usage
optimization going on..   :-)

-Will

> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
