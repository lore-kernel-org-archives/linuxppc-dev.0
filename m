Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 25E0FDDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 15:48:25 +1100 (EST)
Date: Wed, 3 Dec 2008 20:26:07 -0800
From: Greg KH <greg@kroah.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: USB reset errors in 2.6.28*
Message-ID: <20081204042607.GC18027@kroah.com>
References: <20081203202953.1f9f3065@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081203202953.1f9f3065@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2008 at 08:29:53PM -0500, Sean MacLennan wrote:
> 
> It then seems to work, but I see corruption on the usb key. I haven't
> looked into it too much since we aren't switching to 2.6.28 anytime
> soon (it breaks our Secure Digital card driver).

What driver is that?  Why would 2.6.28 be broken?  If it's an
out-of-tree driver, please let me know and I'll be glad to get it
merged.

thanks,

greg k-h
