In-Reply-To: <1087207803.7360.83.camel@newt>
References: <1087207803.7360.83.camel@newt>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E1775B59-BE08-11D8-8344-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
Date: Mon, 14 Jun 2004 08:43:55 -0500
To: Adrian Cox <adrian@humboldt.co.uk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jun 14, 2004, at 5:10 AM, Adrian Cox wrote:

> The attached patch is a start at adding the internal peripherals of the
> MPC107/MPC8240/MPC8245 to the OCP bus. I've used thus in the 2.6 port
> of
> my MPC107 I2C driver, which follows shortly. I intend to use this for
> the DMA controller later, once I decide what device ID to give it.
> I'm a little uncertain about OCP device IDs. Should there be a separate
> I2C device ID for each different I2C programming interface from the
> same
> vendor? Motorola have already given us two separate implementations on
> PowerPC.

Take a look at the driver i2c-mpc.c in
bk://ppc.bkbits.net/linuxppc-2.4.  We have been trying to write a
single driver to handle as many variations of one device as possible.
Our expectation is that one driver should hopefully be able to handle
10x, 824x, 85xx.  (and some future device families 83xx & 86xx).

I've also pushed support for 85xx infrastructure into linuxppc-2.5
which includes support for some config options for Motorola/Freescale
OCP.  These changes are expected to make it into linux-2.5 after 2.6.7
is released.

We are looking at adding OCP support for 824x as well for the I2C
driver.

I will make sure to look over the code and provide any feedback I've
got.

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
