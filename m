Return-Path: <marco.stornelli@coritel.it>
Message-ID: <4850CD52.60008@coritel.it>
Date: Thu, 12 Jun 2008 09:16:34 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Reinhard Weiss <reinhard.weiss@lauterbach.com>
Subject: Re: PCI Express error on MPC8641D-HPCN
References: <20080611171502.E87EFDE5C9@ozlabs.org>
In-Reply-To: <20080611171502.E87EFDE5C9@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Reinhard Weiss ha scritto:
> Hi,
> 
> I try to get 2.6.25.6 running on Freescale's MPC8641D-HPCN (Processor is revision 1), but somehow the PCI express controller setup fails:
> 
> PCI: Probing PCI hardware
> PCI: 0000:00:00.0: class b20 doesn't match header type 01. Ignoring class.
> PCI: 0001:02:00.0: class b20 doesn't match header type 01. Ignoring class.
> PCI: Closing bogus Apple Firmware region 1 on bus 0x03
> PCI: Closing bogus Apple Firmware region 2 on bus 0x03
> PCI: Cannot allocate resource region 0 of device 0000:01:1d.0, will remap
> PCI: Cannot allocate resource region 1 of device 0000:01:1d.1, will remap
> PCI: Failed to allocate I/O resource #0:100@1000 for 0000:01:1d.0
> PCI: Failed to allocate I/O resource #1:100@1000 for 0000:01:1d.1
> PCI: not setting up bridge 0000:00:00.0 for bus 1
> PCI: Enabling device 0000:00:00.0 (0106 -> 0107)
> PCI: not setting up bridge 0001:02:00.0 for bus 3
> PCI: Enabling device 0001:02:00.0 (0106 -> 0107)
> 
> - PCIe worked with 2.6.20.7 on this board, but unfortunately SMP support was not ready then. 
> - on MPC8610-HPCD, PCIe works with 2.6.25.6, so I wonder what could be the difference.
> 
> Any ideas?
> 
> Best regards,
> Reinhard
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

I'm working with this board and I'm beginning to doubt that the pci 
express works well. You can see my problems in my previous posts in this 
mailing list sometimes ago.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
