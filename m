Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 162EEB7BC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:33:47 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "rubini@gnudd.com" <rubini@gnudd.com>
Date: Tue, 27 Oct 2009 16:33:39 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330D368A8@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<20091027223221.GA11293@mail.gnudd.com>
In-Reply-To: <20091027223221.GA11293@mail.gnudd.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "bgat@billgatliff.com" <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Okay, I now have access to the flash memory, however when I write
> to
> > it the writes do not take.
>=20
>=20
> > 			(PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,
>=20
> MAP_SHARED. Bill told you.  With MAP_PRIVATE you write to a local
> in-ram copy of the data, not to the original one.

I apologize, that MAP_PRIVATE was leftover from me trying to get it to work=
.  With MAP_SHARED I am having the problem.

Sorry for the confusion.
