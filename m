Subject: Re: MPC8560ADS issues
From: Jason McMullan <jason.mcmullan@timesys.com>
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1079019785.29565.36.camel@chuck.arlut.utexas.edu>
References: <1078945499.3748.4.camel@veena.timesys>
	 <1079019785.29565.36.camel@chuck.arlut.utexas.edu>
Message-Id: <1079030575.3748.55.camel@veena.timesys>
Mime-Version: 1.0
Date: Thu, 11 Mar 2004 13:42:55 -0500
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-03-11 at 10:43, Matthew S. McClintock wrote:
> What version of u-boot are you using? There was a patch around Feb.
> 24th that fixed some things in the ethernet driver for u-boot.
> Although since you seem to have the TSEC ports working it seems you
> have the latest version.

	Latest CVS. But my questions are about *Linux*. I'm running
Linux 2.6.0 with a port of the MPC8560 support from LinuxPPC 2.4.x.
Got the Gianfar (TSEC) port to work just fine, and I can see the PHYs
for the FCCs, and I get *TX* interrupts, and *sometimes* get packets
out the wire, but no RX, and often TXs with no packets.

--
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
