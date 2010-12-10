Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E85A4B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 09:34:25 +1100 (EST)
Date: Fri, 10 Dec 2010 14:33:20 -0800
From: Greg KH <greg@kroah.com>
To: tmarri@apm.com
Subject: Re: [PATCH V6 01/10] USB/ppc4xx: Add Synopsys DWC OTG Register
	definitions
Message-ID: <20101210223320.GA8227@kroah.com>
References: <1291854722-24744-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291854722-24744-1-git-send-email-tmarri@apm.com>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 08, 2010 at 04:32:02PM -0800, tmarri@apm.com wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> Add Synopsys Design Ware core register definitions.
> 
> Signed-off-by: Tirumala R Marri<tmarri@apm.com>

Minor nit for future patches, you need a space after your name and
before the '<' character.

thanks,

greg k-h
