Message-ID: <412CCF6F.6040800@eircom.net>
Date: Wed, 25 Aug 2004 18:42:07 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: Conor McLoughlin <cml3227@eircom.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone with MPC82xx PCI on kernel 2.6?
References: <4124E315.9090009@eircom.net> <412CC13A.2050009@eircom.net>
In-Reply-To: <412CC13A.2050009@eircom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conor McLoughlin wrote:
> Now I try to access the devices on bus 1. I can read the configuration
> space no problem, but get bus error if I read the pci memory space.
> Checking everything obvious, I see that the the command register of
> the pci-pci bridge does not have the memory or I/O space bits set.
> Setting these bits eliminates the bus error.

I have now discovered that the same bits were not set for the devices
on bus 1. I am now reading reasonable values from the device :-)

I still need to know where these bits should be setup.

Conor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
