Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 0B163B7BB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 04:01:31 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 29 Oct 2009 11:01:23 -0600
Subject: RE: Accessing flash directly from User Space [SOLVED]
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E22AC7@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<20091028112430.GO22408@zod.rchland.ibm.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A3D@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E22259@midas.usurf.usu.edu>
	<OFE3AA516D.46A96178-ONC125765E.0030DA7C-C125765E.00317B8C@transmode.se>
	<OF8B45B496.CDDD0639-ONC125765E.0032ACFE-C125765E.0032E44F@transmode.se>
In-Reply-To: <OF8B45B496.CDDD0639-ONC125765E.0032ACFE-C125765E.0032E44F@transmode.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Bill Gatliff <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Does O_DIRECT help? (you may need to define _GNU_SOURCE before
> #include)


Nope, O_DIRECT did not help - in fact it caused the application to crash.  =
Why that is I am not sure, but it crashed.
