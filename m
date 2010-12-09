Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AB1C9B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 17:48:19 +1100 (EST)
Date: Wed, 8 Dec 2010 22:47:37 -0800
From: Greg KH <greg@kroah.com>
To: tmarri@apm.com
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
Message-ID: <20101209064737.GA10820@kroah.com>
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

Much nicer, thanks.

Do you wish for me to apply this to the tree if it passes review?

thanks,

greg k-h
