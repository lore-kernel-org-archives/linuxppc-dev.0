Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9DE2AB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 09:44:22 +1100 (EST)
Date: Fri, 10 Dec 2010 14:44:02 -0800
From: Greg KH <greg@kroah.com>
To: tmarri@apm.com
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
Message-ID: <20101210224402.GA8943@kroah.com>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291854539-23879-1-git-send-email-tmarri@apm.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 08, 2010 at 04:28:59PM -0800, tmarri@apm.com wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> v6:
>  1. Replaced register definitions and bit fields with macros.
>  2. Replace printks with dev_dbg or dev_err functions.
>  3. Cleanup some assignments.
>  4. Remove chip specific selections in Kconfig file.

There are still a lot of checkpatch errors and warnings in these
patches.  Patch 1-8 has:
	total: 64 errors, 126 warnings, 13905 lines checked

Care to fix all of these up in your next submission?  I can't take these
as-is, sorry.

And, if you haven't run checkpatch.pl before, odds are you haven't run
'sparse'.  Please run that as well and resolve the issues it finds.

thanks,

greg k-h
