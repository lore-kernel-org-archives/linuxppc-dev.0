Return-Path: <kkeil@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD52EDDE02
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 22:57:05 +1000 (EST)
Date: Mon, 4 Aug 2008 14:56:50 +0200
From: Karsten Keil <kkeil@suse.de>
To: Sinan Akman <sinan@writeme.com>
Subject: Re: mISDN still breaking the allmodconfig build...
Message-ID: <20080804125650.GC20260@pingi.kke.suse.de>
References: <20080727.170235.97056809.davem@davemloft.net>
	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
	<20080727.180736.74131389.davem@davemloft.net>
	<7949EA87-4340-4353-AFC9-79A718B95DF0@holtmann.org>
	<20080728084024.GA23465@pingi.kke.suse.de>
	<488DC046.7060802@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <488DC046.7060802@writeme.com>
Cc: sfr@canb.auug.org.au, Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 08:49:10AM -0400, Sinan Akman wrote:
> Karsten Keil wrote:
> >[...]
> >virt_to_bus() I never got a complain before and yes I already have some 
> >patches
> >to solve the endian issues in the HFC driver, but it was not finaly
> 
>   Karsten, do you have those patches available somewhere ?
> I could give it a try on  4xx with a 4s card in the near future.
> 

Already fixed in
git://git.kernel.org/pub/scm/linux/kernel/git/kkeil/ISDN-2.6.git

-- 
Karsten Keil
SuSE Labs
ISDN and VOIP development
SUSE LINUX Products GmbH, Maxfeldstr.5 90409 Nuernberg, GF: Markus Rex, HRB 16746 (AG Nuernberg)
