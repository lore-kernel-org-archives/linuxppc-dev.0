Return-Path: <clemens.koller@anagramm.de>
Message-ID: <46CEDAD5.1070506@anagramm.de>
Date: Fri, 24 Aug 2007 15:19:17 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Jose Almeida <jalmeida@sysgo.fr>
Subject: Re: little endian page mapping on PQ3
References: <46CE8FD5.2060609@sysgo.fr>
In-Reply-To: <46CE8FD5.2060609@sysgo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Jose!

Jose Almeida schrieb:
> Hi all,
> 
> Looking at PQ3 documentation, it looks like there is a way to select
> on a page basis if we would like to map one particular page in BIG or
> LITTLE endian.
> This is a very nice feature when you need to exchange some data
> between a PC and a PQ3 target.

I would be interested, however cannot spend time right now to work
on that subject.

> I am wondering if someone have already tryed this PQ3 feature ?
> I guess this would require some kind of hook in the kernel ...

Just some random bits I found in the web:
http://developer.apple.com/documentation/Hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/PCI_BOOK.250.html

The Interesting part is:
"Thus, the address swizzle is completely transparent to software."

So, I would just try to setup some memory mapping and turn on little endian
mode to access that area... MMMV. Just a guess.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
