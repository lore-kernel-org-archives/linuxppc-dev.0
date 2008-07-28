Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 12C92DE1BB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 02:24:50 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so604815yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 09:24:48 -0700 (PDT)
Date: Mon, 28 Jul 2008 10:24:45 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Changing Mac address
Message-ID: <20080728162445.GB21039@secretlab.ca>
References: <106201c8f0bd$dda4f640$ad289e86@LPSC0173W>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <106201c8f0bd$dda4f640$ad289e86@LPSC0173W>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 04:25:54PM +0200, Guillaume Dargaud wrote:
> Hello all,
> there's something I miss here. I'd like to setup a MAC address in 
> software at the start of the boot process. I'm trying to figure out where 
> this is done in the kernel code.
> I'm on a custom variant of a Xilinx ML405 card, still in PPC arch.
> So it appears to be going in the arch/ppc/boot/simple/embed_config.c 

Yes, this is the correct location to set it.  Do whatever you need to
set a different MAC address.

In arch/powerpc this all goes away and you can just set it in the device
tree.

g.
