Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id C40B7B7D61
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Jun 2010 09:56:57 +1000 (EST)
Received: by gwj15 with SMTP id 15so532512gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Jun 2010 16:56:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <b9420114-c787-43c2-9401-1e86dd2a5ede@VA3EHSMHS027.ehs.local>
References: <20100603211755.7822.66.stgit@angua>
	<AANLkTilzGOkvjghvMh3E0kqIWzyZEdG2iF85Dt_d-Rbk@mail.gmail.com>
	<b9420114-c787-43c2-9401-1e86dd2a5ede@VA3EHSMHS027.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 3 Jun 2010 17:56:35 -0600
Message-ID: <AANLkTik-zGqPVecmxES4vFhSo8XoirKjC-78sTcNpQiZ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/5200: Update defconfigs
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 3, 2010 at 5:22 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> It seems to me like what's confused in the defconfigs is two concepts:
> 1) The requirements of a platform (what options must be set and must not
> be set)
> 2) The guarantee that a particular config was known to work at some
> point in time.

I can't speak for other maintainers; but #2 is not something I worry
about w.r.t. defconfigs.  That guarantee is pretty meaningless for
anything but an exact version of the kernel tree.

> The first could allow you to drop 99% of the options (I think that this
> mainly what Linus objects to)

That, and the fact that the current files are machine-generated as
opposed to something written/edited/maintained by a human.

> The second is better handled with testing anyway (assuming that all of
> the unmentioned options are, in fact, unset)

Yup.

g.
