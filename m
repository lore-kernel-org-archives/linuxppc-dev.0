Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 94ACCDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 19:58:32 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: i2c support for MPC 8247
Date: Thu, 4 Dec 2008 09:58:28 +0100
References: <loom.20081204T014044-850@post.gmane.org>
In-Reply-To: <loom.20081204T014044-850@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812040958.28687.laurentp@cse-semaphore.com>
Cc: Daniel Ng <daniel_ng11@lycos.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Daniel,

On Thursday 04 December 2008 02:49:45 Daniel Ng wrote:
> Hi,
>
> We were successfully using drivers/i2c/busses/i2c-mpc8260.c for I2C support
> on a MPC8247 in Linux 2.6.14.
>
> Now, we are wanting to upgrade our embedded system to Linux 2.6.24.
>
> However, in 2.6.24, the file i2c-mpc8260.c doesn't exist. There is a
> i2c-mpc.c but this doesn't seem to handle the MPC8247. This is because I
> get the following message when I try to access the I2C device:
>
> "/dev/i2c-0: No such device"
>
> Perhaps the i2c-mpc.c driver uses a different device node? There is nothing
> in the i2c-mpc.c file which specifies a particular dev node.
>
> Is I2C supported on the MPC8247 in Linux 2.6.24?
>
> If so, what is the appropriate driver file?

The MPC8247 I2C controller is supported by the i2c-cpm driver, introduced in 
2.6.27. It shouldn't be difficult to backport the driver to 2.6.24. Please 
note that the driver only supports the powerpc architecture and won't work on 
ppc kernels.

Alternatively, you could port the i2c-mpc8260 driver to 2.6.24.

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
