Return-Path: <kraxel@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9DBE667B8F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 20:10:57 +1100 (EST)
Message-ID: <457E7215.3010707@suse.de>
Date: Tue, 12 Dec 2006 10:10:45 +0100
From: Gerd Hoffmann <kraxel@suse.de>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
References: <20061211185536.GA19338@aepfle.de>	<Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>	<17789.54777.283849.950002@cargo.ozlabs.ibm.com>
	<20061211.160541.111202759.davem@davemloft.net>
In-Reply-To: <20061211.160541.111202759.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, olaf@aepfle.de, drfickle@us.ibm.com,
	linux-kernel@vger.kernel.org, ak@suse.de,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Hi,

> That only gives you the version, not the whole version string, but you
> could put the whole string in such a location when adding such a
> facility to powerpc if you wanted to.

Hmm, as we have those fancy ELFNOTE macros now, can't we just the
version string into one?

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
