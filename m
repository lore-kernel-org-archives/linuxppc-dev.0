Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B543BB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 06:02:10 +1100 (EST)
Date: Sun, 12 Dec 2010 10:48:34 -0800
From: Greg KH <greg@kroah.com>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH -mm 4/4] RapidIO: Add new sysfs attributes
Message-ID: <20101212184834.GA17052@kroah.com>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
	<1292013498-31406-5-git-send-email-alexandre.bounine@idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292013498-31406-5-git-send-email-alexandre.bounine@idt.com>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 10, 2010 at 03:38:18PM -0500, Alexandre Bounine wrote:
> Add new sysfs attributes.

Like Andrew pointed out, all sysfs files are required to have entries in
Documentation/ABI.  If the existing rapidio sysfs files are not
documented, please document them in there _before_ adding new ones.

thanks,

greg k-h
