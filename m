Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0733B70D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 12:16:34 +1000 (EST)
Date: Wed, 8 Sep 2010 21:16:32 -0500
From: Olof Johansson <olof@lixom.net>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: Combining defconfigs for 44x based boards
Message-ID: <20100909021632.GA16215@lixom.net>
References: <a3a9eb5a2e770f931950ad13c01960da@mail.gmail.com>
	<20100909004957.GA13061@lixom.net>
	<b1e9b49612809d568bd1a4bdd1607b07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1e9b49612809d568bd1a4bdd1607b07@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 08, 2010 at 07:11:11PM -0700, Tirumala Marri wrote:
> >
> > On Wed, Sep 08, 2010 at 03:40:37PM -0700, Tirumala Marri wrote:
> > > Is anyone working on Linus suggestion to combine the defconfigs under
> > 44x
> > > or 4xx ?
> >
> > Do you mean ppc44x_defconfig? Already there.
> No it is not there yet. I should have said "Linus suggestion about
> defconfigs in ARM mailing list".

ARM and powerpc are somewhat different in this aspect, since
ARM traditionally has not been able to build multiplatform kernels
(especially not multi-soc-family kernels).

Powerpc can build a kernel that will boot on all machines of a certain
class (server, fsl-booke, ibm-booke, ppc32). So there's not really
a whole lot of reason to have the custom per-board defconfigs in the
kernel tree any more.

For specific products it might still make sense for a vendor to make a custom
minimal defconfig, but that doesn't mean it's a requirement to have them in the
upstream repository.


-Olof
