Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DAA0567A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 01:24:16 +1000 (EST)
Date: Mon, 18 Apr 2005 08:24:05 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Bellino, Phil" <pbellino@mrv.com>
Message-ID: <20050418152405.GE8014@gate.ebshome.net>
References: <19EE6EC66973A5408FBE4CB7772F6F0A02899377@ltnmail.xyplex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19EE6EC66973A5408FBE4CB7772F6F0A02899377@ltnmail.xyplex.com>
Cc: LinuxPPC <linuxppc-embedded@ozlabs.org>
Subject: Re: 2.6.11 kernel, PPC, and IPv6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2005 at 09:20:39AM -0400, Bellino, Phil wrote:
> I do not know if this email is appropriate for this mailing list, but I
> thought I would give it a try.
> 
> Is there anyone out there who is using(or attempting to use) IPv6 with PPC
> and a 2.6.11 kernel with whom I could email directly with some specific
> questions?

I'm using IPv6 on my powerbook and 440GX ref platform (Ocotea). They 
both seems to get link-local and global addresses (from local router 
running radvd) just fine.

But don't mail me directly :), if you have questions - just ask the 
list, although I don't think this a proper place. Try netdev list 
(netdev@oss.sgi.com)

-- 
Eugene
