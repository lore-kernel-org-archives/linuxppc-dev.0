Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1254892467.6035.273.camel@pasglop>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
	<1254892467.6035.273.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 7 Oct 2009 07:41:20 -0600
Message-ID: <fa686aa40910070641g561ec833vf1cf1a0e098cdbe6@mail.gmail.com>
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device tree
	representation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 6, 2009 at 11:14 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-10-06 at 22:30 -0600, Grant Likely wrote:
>
>> --- /dev/null
>> +++ b/include/linux/of_fdt.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Definitions for working with the Flattened Device Tree data format
>> + *
>> + * Copyright (C) 1996-2005 Paul Mackerras.
>> + *
>> + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
>> + * Updates for SPARC by David S. Miller
>> + * Merged to common code by Grant Likely
>
> I think you should prune the above. Make it (c) myself since I wrote the
> FDT code initially. You can add back (c) of other people as you add more
> stuff here I suppose.
>
> No big deal tho.

No problem.  What is the exact copyright text that you'd like to see
here?  I'm not going to guess on other people's copyright notice.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
