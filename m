Return-Path: <KokHow.Teh@marconi.com>
To: Phil.Nitschke@avalon.com.au, Linuxppc-embedded@ozlabs.org
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Thu, 22 Dec 2005 10:59:40 +0800
Message-ID: <OF7D277018.6306C605-ON482570DF.000BABCC@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Re: linux DMA capabilities in MV64460
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>Currently there is a 2M aperture on the device, but it is not being seen
>as "prefetchable", so when I try to get data from the device using
>repetitive reads, they are very slow.  Hence my efforts to get DMA
>happening.

>Presumably the CPU/bridge discovers PCI device memory regions during bus
>enumeration.  What characteristic of a device determines whether the
>memory region is going to be marked as "prefetchable"?

Being "prefetchable" or not is determined by bit-3 of PCI Memory BAR.

>Does this attribute also affect whether DMA will work?


  MAG> You may want to pick up "PCI System Architecture" from Mindshare,
  MAG> Inc.  There are ones for PCI-X and PCI-Express too, I think.
  MAG> Well worth the money.

>Sounds like a good idea.  I'd hoped not to have to become a PCI expert,
>but it seems that there is a lot for me to learn just to determine how
>best to design my driver.

Here is a good online reference but it does not cover dma and
cache-coherency in great details.
http://www.tldp.org/LDP/tlk/dd/pci.html
