Date: Wed, 4 Dec 2002 10:38:39 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
Subject: looking for documentation on porting Linux to PowerPC platforms
Message-ID: <20021204103839.A28568@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

Is there a document somewhere describing the basics about the PowerPC
platform and Linux, i.e.

a) how to boot linux (can I just branch to the the address where I loaded t
he
image into ram or do I need to setup registers / data structures beforehand?)

b) where/what do I change if I want to add a "sub" architecture?

I've got a ICP-PPC PowerPC backplane type system here which I want to get
Linux on. It has the MPC8240 CPU on it which from what I read is pretty much
the same as the 8260, 8245, etc. (they're all based on the 603e core right?)

Now, if I select "8xx" in menuconfig, I get another selection of machine
types (RPX-Lite, RPX-Classic, etc.). Obviously I need to own my own machine
type here, but how do I do that. Also, how does these machine types differ?
Just different peripherals? Do they have anything in common (e.g. uart).

--

Regards
 Abraham

love, v.:
	I'll let you play with my life if you'll let me play with yours.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
