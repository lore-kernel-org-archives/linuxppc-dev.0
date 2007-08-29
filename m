Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND02.psi.ch (mailsend02.psi.ch [129.129.191.54])
	by ozlabs.org (Postfix) with ESMTP id D58BDDDD07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 01:32:53 +1000 (EST)
Date: Wed, 29 Aug 2007 17:32:49 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708280828h408ce7damf04b31a2048d40c4@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708291351460.11545-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have done further investigation with bootelf and zImage.elf (from
u-boot) and it seems to be that the system fails during image
uncompression: The last command executed is: r = zlib_inflate(&s,
Z_FINISH); /* file: ./arch/ppc/boot/common/misc-common.c */

zlib_inflate function code is in ./lib/zlib_inflate/inflate.c


Mirek



On Tue, 28 Aug 2007, Grant Likely wrote:

> On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > This buffer refers to the kernel which I boot straight from jtag but not
> > u-boot.
> 
> /me remembers something....
> 
> How big is your kernel image?  Seems to me I've had problems with
> kernel images that were too large not being uncompressed properly.
> Can you hook up GDB and debug u-boot?  Find out where it is hanging?
> 
> g.
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
