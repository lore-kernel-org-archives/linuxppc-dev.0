Message-ID: <150401c3f639$a2c0d0e0$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "digger vermont" <digver@verizon.net>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: <debian-powerpc@lists.debian.org>,
	"linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
References: <1077074495.1082.94.camel@gaston> <1077120235.22989.88.camel@myrna>
Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
Date: Wed, 18 Feb 2004 17:09:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 2.6.3-rc2-ben1 compiled fine.  Does this have to do with your patch or
> did I screw up my configuration?


new radeonfb wants i2c-core in the kernel (CONFIG_I2C_CORE=y).

--
Colin
  This message represents the official view of the voices
  in my head.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
