Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06002DE224
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 00:33:37 +1000 (EST)
Message-ID: <48A2F087.5060501@freescale.com>
Date: Wed, 13 Aug 2008 09:32:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
	<20080807061254.GB12571@yookeroo.seuss>
	<20080813054121.GG17587@secretlab.ca>
In-Reply-To: <20080813054121.GG17587@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> So, seeing as settling on a way to determine stdout still up in the air,
> it probably makes sense to condense that code down to a single
> authoritative function so that changes in this area are contained in one
> place.  For now, I'll stick with decoding linux,stdout-path and on Sparc
> decoding the ihandle with the expectation that there will be further
> refinements to be made.

Ack.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
