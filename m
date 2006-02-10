Return-Path: <sr@denx.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id D741467B5D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 04:59:57 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
Date: Fri, 10 Feb 2006 18:59:24 +0100
References: <20060209003459.0ED30352564@atlas.denx.de>
	<200602100847.54363.sr@denx.de> <43ECC7CE.1010409@ovro.caltech.edu>
In-Reply-To: <43ECC7CE.1010409@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602101859.24830.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

On Friday 10 February 2006 18:05, David Hawkins wrote:
> There's actually an additional issue with the 440EP
> for my application. I'll be using it in a 5V PCI
> environment (due to the reuse of the existing host
> CPUs).

Autsch! Those must be pretty old CPU's! Is this standard desktop PCI or 
CompactPCI or PMC?

> Since the 440EP is not 5V tolerant, I figured 
> I would add clamps or buffers to the board design.

I would be careful here, since you easily can violate the pci specs. Do you 
have other pci devices on this pci bus?

Just use newer host CPU's! ;-)

Best regards,
Stefan
