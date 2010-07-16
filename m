Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 37596B6F04
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 17:13:02 +1000 (EST)
Date: Fri, 16 Jul 2010 00:13:20 -0700
From: Greg KH <greg@kroah.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/7] De-couple sysfs memory directories from memory
	sections
Message-ID: <20100716071320.GC31612@kroah.com>
References: <4C3B3446.5090302@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C3B3446.5090302@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 12, 2010 at 10:27:02AM -0500, Nathan Fontenot wrote:
> This set of patches de-couples the idea that there is a single
> directory in sysfs for each memory section.

Any reason you didn't cc: the sysfs maintainer on these patches?  If
not, I'll gladly ignore them...

(hint, scripts/get_maintainer.pl is your friend...)

greg k-h
