Message-Id: <4.2.1.10.19991020200534.00c18220@mail.lauterbach.com>
Date: Wed, 20 Oct 1999 20:07:58 +0200
To: darkmane@w-link.net
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: glibc
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.10.9910201050310.9073-100000@darkmane.w-link.ne
 t>
References: <4.2.1.10.19991020174401.04437670@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 20:13 20.10.99 , Sean Chitwood wrote:
>Hi-
>         I have just built the glibc-2.1.3-0a, before I replace 
> glibc-2.1.1-6c,  does anyone know if any problems will occur? Also how 
> can I compile against the libraries w/o installing them?

If the RPM built fine and a "make check" in build directory passed, the new 
library is OK.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
