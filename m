Return-Path: <j.borkhuis@dutchspace.nl>
Message-ID: <473167E4.8070407@dutchspace.nl>
Date: Wed, 07 Nov 2007 08:23:16 +0100
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: PCI speed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I an having some throughput problems with my PCI. I am using a MVME3100 
board with on board PMC slots. I use a card with a large amount of 
memory on board (64 MB Reflective Memory card) and try to transfer data 
from the card to main memory using the DMA engine on the card.

When using standard memcpy I get a throughput of around 17 MB/s. When I 
use the DMA engine on the PCI card it improves to around 30 MB/s, but 
when I run the same test on an Intel machine the memcpy is the same, but 
the DMA increases to 200 MB/s. Is there some configuration that we can 
change to improve the speed on the PPC board?

I use the same driver code and the same test application on both platforms.

Kind regards,
    Johan Borkhuis
