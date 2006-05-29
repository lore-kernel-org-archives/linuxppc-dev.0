Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17531.28154.10836.832225@cargo.ozlabs.ibm.com>
Date: Tue, 30 May 2006 07:56:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
In-Reply-To: <1148935262.25048.31.camel@brick>
References: <1148935262.25048.31.camel@brick>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michal Ostrowski writes:

> Platforms can choose the default configuration (which is to
> say identity mappings of IRQ vectors 0..511) or specify their own
> configuration:  an offset (for ISA vectors), the range that is to be

Given that the decree has come down from on high that irq 0 is always
to mean "none" or "no IRQ", I have been thinking that we should use
the ISA offset everywhere, even on machines without any ISA hardware.

Paul.
