Date: Wed, 14 Feb 2001 14:28:40 -0500
From: =?ISO-8859-1?Q?S=E9bastien_C=F4t=E9?= <scote1@matrox.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Page table -> SDR1
Message-ID: <20010214142840.A19657@dyn-52-73.matrox.com>
References: <5D2136DF3DD5D311AE89009027C67FB003138BA8@fmsmsx96.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <5D2136DF3DD5D311AE89009027C67FB003138BA8@fmsmsx96.fm.intel.com>; from haifei.zheng@intel.com on Wed, Feb 14, 2001 at 14:00:57 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello again,

Can someone explain me how the base address for the page table is set ?
Looking at hashtable.S, it should be set to 0x180000 and be 256 kB long.
However, when SDR1 is set in turn_on_mmu (head.S), they use _SDR1 to set
the value but I couldn't find anywhere where _SDR1 is set!

Also, when I check the value in the register SRD1, the HTABORG part (bits
0-15) show 0xE so this isn't 0x180000.  Finally, the value of HTABMASK
(bits 23-31) doesn't correcpond to what is recommended in the PowerPC book
from Motorola for 32 MB of RAM and a 256 kB page table.

To me, it seems like the page table isn't set up correctly but since I
don't really understand how it is done, maybe I'm wrong.  I would also be
very surprised to get that far (jumping to the first instruction of init)
without page table.  A little help about this would be very appreciated.


Sébastien Côté


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
