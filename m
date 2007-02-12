Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
Date: Mon, 12 Feb 2007 19:54:18 +0100
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
	<ada7iun8bz3.fsf@cisco.com>
In-Reply-To: <ada7iun8bz3.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702121954.18769.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,

On Monday 12 February 2007 19:30, Roland Dreier wrote:
> Hey Ben, is this work available anywhere?  I am planning on getting
> Katmai (new 440SPe eval board) going soon.  It looks like it will take
> only trivial changes from Yucca (old 440SPe eval board) so I'm
> planning on doing it for arch/ppc first, but I'd be happy to get the
> 440SPe (esp. PCIe stuff) moved to arch/powerpc as soon as makes sense.

I already have a preliminary Katmai Linux (and U-Boot by the way) port in my 
queue. Just some PCI-E tests missing and the Xilinx SYSACE driver. Hopefully 
I can post this port in the next week or so.

And it's of course also still a arch/ppc port. :-(

Best regards,
Stefan
