Return-Path: <Marc.Howard@KLA-Tencor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How does Linux treat memory above the "mem=" mark?
Date: Tue, 17 Oct 2006 11:04:27 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE031D7613@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have a PPC440GX board with 512M of memory.  I use "mem=3D496M" boot
argument to keep Linux from using the uppermost 16MB of memory.  That
region of memory is instead used for hardware communications.
Occasionally however the CPU will read/write this space as well.

My questions concerns TLB entries.  How does Linux define this region in
the TLB?  Does it define this region as non-cacheable in the TLB?  If
not, what is the correct way to define an area of memory that is outside
the OS's control as non-cacheable?

Thanks,

Marc W. Howard
marc.howard@kla-tencor.com
