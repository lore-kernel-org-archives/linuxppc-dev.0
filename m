Subject: Re: getting at bootp IP address
To: bsapp@lanl.gov
Date: Mon, 25 Sep 2000 16:40:51 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39CA8E56.31BB8000@lanl.gov> from "Ben Sapp" at Sep 21, 2000 04:40:22 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000925054051.D1A36218@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ben Sapp writes:
> I would like the program that is started in place of init in the ram disk
> to set up the network based upon the IP address that was obtained from
> bootp.

You should be able to get the ethernet interface's IP address using the
SIOCSIFADDR ioctl (and friends) on ifr_name "eth0".

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
