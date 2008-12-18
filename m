Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7016DDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 21:35:52 +1100 (EST)
Date: Thu, 18 Dec 2008 10:06:35 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: Please pull bjdoo ks' i2c-fixes
Message-ID: <20081218100635.GH8032@fluff.org.uk>
References: <E1LChEf-0000Ts-53@teyla.home.fluff.org>
	<4948E89A.7080703@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4948E89A.7080703@scram.de>
Cc: Mike Ditto <mditto@consentry.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	khali@linux-fr.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17, 2008 at 12:55:06PM +0100, Jochen Friedrich wrote:
> Hi Ben,
> 
> > Mike Ditto (1):
> >       i2c-cpm: Detect and report NAK right away instead of timing out
> 
> Could you also have a look at http://patchwork.ozlabs.org/patch/7452/ ?
> (Discussion at http://patchwork.ozlabs.org/patch/6666/ )
> 
> IIRC, Kumar prefers to push this via your tree.

Ok, but this isn't really a fix, so I'll look at putting it into my
i2c-next tree, not i2c-fixes.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
