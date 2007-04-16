Return-Path: <kelsey@codemonkey.net>
Received: from z.codemonkey.net (z.codemonkey.net [64.142.120.45])
	by ozlabs.org (Postfix) with ESMTP id 91131DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 06:07:36 +1000 (EST)
Date: Mon, 16 Apr 2007 13:35:29 -0600
From: Kelsey Dawes <kelsey@codemonkey.net>
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: DMA Puzzle
Message-ID: <20070416193529.GE31265@nimrod.unx.ca>
References: <OF2330A747.4AF0C4FD-ON882572BB.0077B95A-882572BB.0078B180@selinc.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1D2@MERCURY.inside.istor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1D2@MERCURY.inside.istor.com>
Cc: Randy Brown <rbrown@istor.com>, Vahid Fereydounkolahi <vahidf@istor.com>,
	Chris Carlson <ccarlson@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2007 at 04:23:00PM -0700, Charles Krinke wrote:
> My apologies for the complexity of this e-mail but DMA seems to be a
> complex subject. Thanks to Ed.S a while back, I have DMA working fine
> from U-Boot, but I am having a problem in Linux with the 8541 processor
> using the 2.6.17.11 kernel. I need to DMA through an outbound address
> translation window setup at 0x8800_0000 and the chip I am DMA'ing to is
> responding to 64bit DAC (Dual Address Cycles) and its memory is setup

<SNIP>

Hi Charles - have you checked the device errata for 8541?  I do not have the details in front of me, but do recall several items specific to DMA  signal to complete DMA transaction.  


Worth a look anyway - 

Kelsey
