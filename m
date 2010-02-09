Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5CB7AB7D6D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 09:41:07 +1100 (EST)
Date: Tue, 9 Feb 2010 14:38:51 -0800
From: Greg KH <greg@kroah.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 0/3] powerpc: mpc5121: PSC UART support
Message-ID: <20100209223849.GA13716@kroah.com>
References: <1265750032-2803-1-git-send-email-agust@denx.de>
	<fa686aa41002091418q2e97919ft2bcf8ad02e050afa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa41002091418q2e97919ft2bcf8ad02e050afa@mail.gmail.com>
Cc: wd@denx.de, dzu@denx.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 09, 2010 at 03:18:57PM -0700, Grant Likely wrote:
> Greg, since this touches powerpc stuff, do you mind if I pick up the
> series into my tree?

No objection at all, feel free to add an:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patches.

thanks,

greg k-h
