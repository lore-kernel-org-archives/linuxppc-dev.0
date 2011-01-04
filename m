Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id 324B7B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 01:30:33 +1100 (EST)
Received: by pxi20 with SMTP id 20so3576650pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 Jan 2011 06:30:32 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 4 Jan 2011 07:30:30 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/dts: fix syntax bugs in bluestone.dts
Message-ID: <20110104143030.GA11738@angua.secretlab.ca>
References: <20110103210715.10427.56175.stgit@localhost6.localdomain6>
	<20110104135930.GA2364@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110104135930.GA2364@zod.rchland.ibm.com>
Cc: tmarri@apm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 04, 2011 at 08:59:31AM -0500, Josh Boyer wrote:
> On Mon, Jan 03, 2011 at 02:07:40PM -0700, Grant Likely wrote:
> >Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >---
> >
> >I'm picking this one up immediately into my next-devicetree branch
> 
> Hm.  So these are of course correct, and with that:
> 
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> but I do wonder how you noticed them?  DTC didn't throw an error when I
> built this originally.  Either way, more diligence on my part would be
> appropriate, but knowing how you came across these might teach me
> something.

I updated the copy of dtc in the kernel and rebuilt all the .dts files.

g.
