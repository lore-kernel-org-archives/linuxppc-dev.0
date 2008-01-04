Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 13:43:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: Outstanding DTC patches?
Message-ID: <20080104024324.GA4326@localhost.localdomain>
References: <1199298062.7345.25.camel@ld0161-tx32>
	<20080103044843.GD25357@localhost.localdomain>
	<E1JAQqT-00056B-FP@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JAQqT-00056B-FP@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 08:14:53AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > 
> > I posted this one a while back, but I guess it dropped through the
> > cracks.
> 
> Yep, sorry.
> 
> > There's also the patch I sent you quite a long time ago that
> > adds a clarifying readme about the licensing situation - that might be
> > an idea for v1.1, too.
> 
> I can not find this; neither locally nor on patchworks.
> Do you have a Subject: line, a URL, or could you
> please repost it?

Ah, I think I sent it by private mail, so it won't be in patchwork.
Here you are:

dtc/libfdt: Add README clarifying licensing

The fact the dtc are distributed together, but have different licenses
can be a bit confusing.  Several people have enquired as to what the
deal is with the libfdt licensing, so this patch adds a README
clarifying the situation with a rationale.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/README.license
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/README.license	2007-11-02 11:43:19.000000000 +1100
@@ -0,0 +1,56 @@
+Licensing and contribution policy of dtc and libfdt
+===================================================
+
+This dtc package contains two pieces of software: dtc itself, and
+libfdt which comprises the files in the libfdt/ subdirectory.  These
+two pieces of software, although closely related, are quite distinct.
+dtc does not incoporate or rely on libfdt for its operation, nor vice
+versa.  It is important that these two pieces of software have
+different license conditions.
+
+As the copyright banners in each source file attest, dtc is licensed
+under the GNU GPL.  The full text of the GPL can be found in the file
+entitled 'GPL' which should be included in this package.  dtc code,
+therefore, may not be incorporated into works which do not have a GPL
+compatible license.
+
+libfdt, however, is GPL/BSD dual-licensed.  That is, it may be used
+either under the terms of the GPL, or under the terms of the 2-clause
+BSD license (aka the ISC license).  The full terms of that license are
+given in the copyright banners of each of the libfdt source files.
+This is, in practice, equivalent to being BSD licensed, since the
+terms of the BSD license are strictly more permissive than the GPL.
+
+I made the decision to license libfdt in this way because I want to
+encourage widespread and correct usage of flattened device trees,
+including by proprietary or otherwise GPL-incompatible firmware or
+tools.  Allowing libfdt to be used under the terms of the BSD license
+makes that it easier for vendors or authors of such software to do so.
+
+This does mean that libfdt code could be "stolen" - say, included in a
+proprietary fimware and extended without contributing those extensions
+back to the libfdt mainline.  While I hope that doesn't happen, I
+believe the goal of allowing libfdt to be widely used is more
+important than avoiding that.  libfdt is quite small, and hardly
+rocket science; so the incentive for such impolite behaviour is small,
+and the inconvenience caused therby is not dire.
+
+Licenses such as the LGPL which would allow code to be used in non-GPL
+software, but also require contributions to be returned were
+considered.  However, libfdt is designed to be used in firmwares and
+other environments with unusual technical constraints.  It's difficult
+to anticipate all possible changes which might be needed to meld
+libfdt into such environments and so difficult to suitably word a
+license that puts the boundary between what is and isn't permitted in
+the intended place.  Again, I judged encouraging widespread use of
+libfdt by keeping the license terms simple and familiar to be the more
+important goal.
+
+**IMPORTANT** It's intended that all of libfdt as released remain
+permissively licensed this way.  Therefore only contributions which
+are released under these terms can be merged into the libfdt mainline.
+
+
+David Gibson <david@gibson.dropbear.id.au>
+(principal original author of dtc and libfdt)
+2 November 2007


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
