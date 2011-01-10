Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1DA3CB710C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Jan 2011 05:44:37 +1100 (EST)
Date: Mon, 10 Jan 2011 10:44:16 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/4] De-couple sysfs memory directories from memory
	sections
Message-ID: <20110110184416.GA18974@kroah.com>
References: <4D2B4B38.80102@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D2B4B38.80102@austin.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 10, 2011 at 12:08:56PM -0600, Nathan Fontenot wrote:
> This is a re-send of the remaining patches that did not make it
> into the last kernel release for de-coupling sysfs memory
> directories from memory sections.  The first three patches of the
> previous set went in, and this is the remaining patches that
> need to be applied.

Well, it's a bit late right now, as we are merging stuff that is already
in our trees, and we are busy with that, so this is likely to be ignored
until after .38-rc1 is out.

So, care to resend this after .38-rc1 is out so people can pay attention
to it?


> The root of this issue is in sysfs directory creation. Every time
> a directory is created a string compare is done against all sibling
> directories to ensure we do not create duplicates.  The list of
> directory nodes in sysfs is kept as an unsorted list which results
> in this being an exponentially longer operation as the number of
> directories are created.

Are you sure this is still an issue?  I thought we solved this last
kernel or so with a simple patch?

thanks,

greg k-h
