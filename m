Date: Thu, 5 Dec 2002 10:54:00 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: looking for documentation on porting Linux to PowerPC platforms
Message-ID: <20021205105400.B3899@crystal.2d3d.co.za>
References: <20021204103839.A28568@crystal.2d3d.co.za> <1039025018.651.43.camel@zion>
Mime-Version: 1.0
In-Reply-To: <1039025018.651.43.camel@zion>; from benh@kernel.crashing.org on Wed, Dec 04, 2002 at 19:03:38 +0100
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Benjamin!

> > Is there a document somewhere describing the basics about the PowerPC
> > platform and Linux, i.e.
>
> Not really afaik, I should probably do this though ;)

It would be really useful to have something like that.

> > a) how to boot linux (can I just branch to the the address where I loaded t
> > he
> > image into ram or do I need to setup registers / data structures beforehand?)
>
> Custom hardware ? Well, that pretty much depends how your implementation
> of early init & setup_arch behaves. The kernel itself can be loaded at
> almost any address on most ppc32 CPUs, it will relocate itself, though
> you probably want to make sure you enter it with MMU translations
> disabled.

What about caches? Do you care whether caching is enabled or not?

--

Regards
 Abraham

The giraffe you thought you offended last week is willing to be nuzzled today.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
