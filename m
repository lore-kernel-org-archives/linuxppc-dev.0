Subject: Re: looking for documentation on porting Linux to PowerPC platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20021205105400.B3899@crystal.2d3d.co.za>
References: <20021204103839.A28568@crystal.2d3d.co.za>
	<1039025018.651.43.camel@zion>  <20021205105400.B3899@crystal.2d3d.co.za>
Content-Type: text/plain
Date: 05 Dec 2002 10:33:18 +0100
Message-Id: <1039080798.651.54.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> What about caches? Do you care whether caching is enabled or not?

Not really. We do enable L1 on "common" desktop CPUs, and machine
specific code may do more with L2 or L3 if any. It's up to you to
either setup additional caches prior to entering the kernel, or from
your machine init code.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
