Message-Id: <200204041445.g34Ejjc14079@gt_tus_au.au.thalesgroup.com>
From: Rosen Jeremy <Rosen.Jeremy@tms-pty.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Date: Thu, 4 Apr 2002 16:40:00 +1000 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> This flag is used on architectures that have memory only accessible
> from the processor, not from a DMA device, to ensure a DMA device
> gets a memory bank that it can access.

so it specifies that the kmalloc()ed region must be usable for DMA
transfer.... which is exactly what we want.

except that for us it has impact on boudries instead of location.

TIA
Jeremy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
