Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id ADD1BB7BCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 07:31:29 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Bill Gatliff <bgat@billgatliff.com>
Date: Tue, 27 Oct 2009 14:31:22 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330D366F7@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
In-Reply-To: <4AE75859.5050108@billgatliff.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Jonathan Haws wrote:
> >>> How can I get that pointer?  Unfortunately I cannot simply use
> the
> >>>
> >> address of the flash.  Is there some magical function call that
> >> gives me access to that portion of the memory space?
> >>
> >> $ man 2 mmap
> >>
> >> You want MAP_SHARED and O_SYNC.
> >>
> >
> >
> > To use that I need to have a file descriptor to a device, do I
> not?  However, I do not have a base flash driver to give me that
> file descriptor.  Am I missing something with that call?
> >
>=20
> /dev/mem


Ah, yes.  I told you this was going to be a dumb question.

Thanks, Bill.

Jonathan
