Subject: Re: [PATCH] kauai ATA for G4 windtunnel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040103182444.GA1309@ibrium.se>
References: <20040103182444.GA1309@ibrium.se>
Content-Type: text/plain
Message-Id: <1073170785.10542.39.camel@gaston>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 09:59:45 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-04 at 05:24, Samuel Rydh wrote:
> Hi,
>
> The kauai ATA support in the 2.5 linuxppc tree for the G4 windtunnel is currently
> broken due to a missing PCI id. The pci_ids.h file defines PCI_DEVICE_ID_APPLE_KAUAI_ATA
> to be 0x3b while the actual hardware (in my machine) has id 0x33.
>
> The following patch fixes the problem (although the define should of course be pushed to
> pci_ids.h).
>

Hi ! This has already been fixed for a long time in my tree
(bk://ppc.bkbits.net/linuxppc-2.5-benh or rsync mirror on
source.mvista.org)

I expect to have all of that stuff merged with Andrew soon, I admit not
bothering much updating linuxppc-2.5 lately...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
