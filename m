Subject: Re: [resolved] Re: 2.6.5/iBook G3: Oops on resume from sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaron Lunansky <muffin@csclub.uwaterloo.ca>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040410012023.GA7393@csclub.uwaterloo.ca>
References: <20040405215318.GA2822@mortadelo.pirispons.net>
	 <20040407191719.GA4852@csclub.uwaterloo.ca>
	 <1081378171.1380.68.camel@gaston>
	 <20040408131404.GA28251@csclub.uwaterloo.ca>
	 <1081490612.1382.125.camel@gaston>
	 <20040409134748.GA11157@csclub.uwaterloo.ca>
	 <1081554759.25144.155.camel@gaston>
	 <20040410012023.GA7393@csclub.uwaterloo.ca>
Content-Type: text/plain
Message-Id: <1081561642.1401.162.camel@gaston>
Mime-Version: 1.0
Date: Sat, 10 Apr 2004 11:47:22 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-10 at 11:20, Aaron Lunansky wrote:
> heh, good call, it was pmac_zilog that was causing the weird behaviour.
> Removed it from my kernel (it was compiled in) and my system sleeps fine now.

Can you enable debugging in the driver (turn #undef DEBUG to #define
DEBUG at the beginning of the driver, you may also need to boot the
kernel with "debug" on the command line to get the messages).

See what messages you get from the driver both during boot and when
trying to suspend. Eventually, add some more output to pmz_suspend()
function to find out where it dies

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
