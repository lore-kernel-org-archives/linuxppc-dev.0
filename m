Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 464E1DDF37
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 15:33:27 +1100 (EST)
Date: Tue, 4 Dec 2007 22:37:32 -0600
From: Olof Johansson <olof@lixom.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Merge dtc
Message-ID: <20071205043732.GA16104@lixom.net>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<20071204163409.6d03c7a5@zod.rchland.ibm.com>
	<18262.2934.447856.686438@cargo.ozlabs.ibm.com>
	<20071204202625.05367103@zod.rchland.ibm.com>
	<20071204220012.1b91c27c@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204220012.1b91c27c@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 10:00:12PM -0600, Josh Boyer wrote:

> So if mkimage is going to be put in-kernel, I'd rather it be in a more
> generic place.  Arguably, dtc should go there as well seeing as how
> microblaze could probably use it too.

Well, kconfig is in scripts/ in spite of not being a script. Maybe
dtc and mkimage should go there too?


-Olof
