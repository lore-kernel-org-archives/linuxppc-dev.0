Return-Path: <glikely@secretlab.ca>
Date: Mon, 4 Aug 2008 11:25:58 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Paul Smith <paul@mad-scientist.us>
Subject: Re: Creating a wrapped zImage.initrd -- can't start the trampoline?
Message-ID: <20080804172558.GA18317@secretlab.ca>
References: <1217644827.6390.12.camel@homebase.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1217644827.6390.12.camel@homebase.localnet>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 01, 2008 at 10:40:27PM -0400, Paul Smith wrote:

> Anyway, I need to generate an all-in-one image containing the kernel and
> the initrd, and the trampoline code tacked onto it to turn it into an
> ELF image.  I'm worried I'll need to write a custom platform_init() but
> for now I'm just using of.c.

Take a look at Documentation/powerpc/bootwrapper.txt

You probably want the 'simpleImage.%' target.  It also binds in a copy
of the device tree blob.

g.
