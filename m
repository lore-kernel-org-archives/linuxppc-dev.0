Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D9C80B70FC
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 15:04:05 +1100 (EST)
Date: Wed, 20 Oct 2010 21:03:00 -0700
From: Greg KH <greg@kroah.com>
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH V5 0/9] Add Synopsys DesignWare HS USB OTG driver
Message-ID: <20101021040300.GA18448@kroah.com>
References: <12876231942694-git-send-email-fchen@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12876231942694-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 20, 2010 at 06:06:34PM -0700, Fushen Chen wrote:
> This patch series add Synopsys DesignWare HS USB OTG driver support.

Unfortunatly this is right at the start of the merge window for me,
which means it is past the window for anything new to go into .37.  Can
you resend this after .37-rc1 comes out and I can review it at that
point in time?

thanks,

greg k-h
