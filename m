Return-Path: <sr@denx.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id 6D96467B36
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 19:06:30 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
Date: Sat, 11 Feb 2006 09:06:05 +0100
References: <20060209003459.0ED30352564@atlas.denx.de>
	<200602101859.24830.sr@denx.de> <43ECD753.5000105@ovro.caltech.edu>
In-Reply-To: <43ECD753.5000105@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602110906.05547.sr@denx.de>
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

On Friday 10 February 2006 19:11, David Hawkins wrote:
> > Just use newer host CPU's! ;-)
>
> Ah, the words of a true engineer :)
>
> Of course the project manager wouldn't appreciate me doing that.
>
> However, its not totally out of the question ... $50 per 21555
> and 20 per crate, thats $1000, about half the price of
> a CPU. But of course, without the I20 unit on the 440EP,
> I might need the 21555 anyway.

Do you really need this I2O unit? You could easily create some message 
ringbuffers, one in the 440EP's SDRAM for the host-to-440 messages and one in 
the host-cpu SDRAM for the 440-to-host messages. This way, all messages will 
be transferred using pci writes.

Best regards,
Stefan
