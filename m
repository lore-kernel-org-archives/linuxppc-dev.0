In-Reply-To: <38b3effd38fb6775@amyris.wanadoo.fr> (added by amyris.wanadoo.fr)
Date: Wed, 23 Feb 2000 18:16:47 +0100
To: Florent <flobo@iname.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: OF doesn't know my hard drive
Message-Id: <20000223181647.026855@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 23, 2000, Florent <flobo@iname.com> wrote:

>What's wrong with the second IDE bus ? (/pci/@d/mac-io/ata3)
>Why is it not located next to the first on the OF three ?
>It seems it lacks appropriate methods to handle hard drives correctly...

On the B&W G3 and Yikes G4, the ata3 bus is inside the mac-io ASIC while
the Ultra/ATA bus is a separate PCI controller (CMD646).

OF should contains appropriate methods for both busses. The core ATA
implementation is not in the device nodes themselves but in the various
packages.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
