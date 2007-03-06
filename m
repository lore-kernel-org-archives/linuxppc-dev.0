Return-Path: <Bruce_Leonard@selinc.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A185@MERCURY.inside.istor.com>
To: "Charles Krinke" <ckrinke@istor.com>
Subject: RE: Endianness versus too many byte swaps??
MIME-Version: 1.0
Message-ID: <OF07643750.0087C9A8-ON88257296.00759603-88257296.0075F01D@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 6 Mar 2007 13:28:11 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Charles

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 03/05/2007 
07:14:56 AM:

> I think the moral of this story is that the drive logic created by my
> predecessor that calls readl/writel to read/write ppc registers needs to
> be changed to call in_be32 & outbe32 so I don't continue a mistake.

Something that I'm not sure has been made clear to you (and I'm speaking 
from 8347 experiance so you situation may be different but I don't think 
so) is that the entire PCI interface on the chip is in little endian mode 
regardless of the endianess you are running the processor in.  That's why 
readl/writel map to in_le32/outle32, it's taking care of the byte swaping 
for you.

bruce
