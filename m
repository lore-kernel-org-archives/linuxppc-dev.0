Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: digger vermont <digver@verizon.net>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1077120235.22989.88.camel@myrna>
References: <1077074495.1082.94.camel@gaston>
	 <1077120235.22989.88.camel@myrna>
Content-Type: text/plain
Message-Id: <1077143469.20781.17.camel@gaston>
Mime-Version: 1.0
Date: Thu, 19 Feb 2004 09:31:09 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-02-19 at 03:03, digger vermont wrote:
> Hello Ben,
>
> 	I just rsync'd to 2.6.3-rc3-ben1 and added your patch.  I get these
> errors:

Known problem with i2c config, make sure you have i2c and i2c-algo-bit
enabled.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
