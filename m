Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Merge refs and labels into single "markers" list 
In-Reply-To: Your message of "Thu, 22 Nov 2007 11:37:07 +1100."
	<20071122003707.GF19445@localhost.localdomain>
References: <20071122003707.GF19445@localhost.localdomain> 
Date: Mon, 26 Nov 2007 16:11:52 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IwmBE-0002f5-L2@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Currently, every 'data' object, used to represent property values, has
> two lists of fixup structures - one for labels and one for references.
> Sometimes we want to look at them separately, but other times we need
> to consider both types of fixup.
> 
> I'm planning to implement string references, where a full path rather
> than a phandle is substituted into a property value.  Adding yet
> another list of fixups for that would start to get messy.  So, this
> patch merges the "refs" and "labels" lists into a single list of
> "markers", each of which has a type field indicating if it represents
> a label or a phandle reference.  String references or any other new
> type of in-data marker will then just need a new type value - merging
> data blocks and other common manipulations will just work.
> 
> While I was at it I made some cleanups to the handling of fixups which
> simplify things further.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
