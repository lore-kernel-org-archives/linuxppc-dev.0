Message-ID: <159C486347C8D3119B1D005004A4694002069176@olive.raritan.com>
From: Steven Rothweiler <Stevenr@raritan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Best Linux/PPC compiler ?
Date: Fri, 16 May 2003 11:09:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

What is the best Linux/PPC compiler?

Specifically, we're using MPC8270.  We are coming from Linux/x86
platform, where Intel has a nice compiler that blows the doors
off of gcc, performance-wise.  I'm wondering if anyone knows if
there have been any studies comparing various Linux/PPC compilers.

We're switching to Linux/PPC for product-cost reasons, not
development-cost reasons, so we have money to spend on the
compiler.  We must make the code run as fast as possible, since
the speed of 450MHz MPC8270 is nothing compared to a GHz Pentium.

FYI, our application is an embedded (lossless) video compression
app, that quickly consumes CPU cycles, unless we're very careful.

Thanks.
--
STeve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
