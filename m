Date: Tue, 8 Jun 2004 16:15:23 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: eepro100 load
Message-ID: <20040608141523.GB9955@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040608070108.GO18676@smtp.barco.com>
Mime-Version: 1.0
In-Reply-To: <20040608070108.GO18676@smtp.barco.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

> 70-80 Mbps with a 350 MHz should be able to handle this without this
> much load (seems to be > 60% in kernel mode for the moment for 56
> Mbps).

The same goes for the e100 driver from Intel (haven't looked at the
non-default settings very much though); perhaps slightly worse as the
eepro100 driver, though the e100 driver seems to be able to limit limit
the resulting errors (overflow) to one source, while the eepro100 driver
distributes the errors over the different network sources, making them
all corrupt.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
