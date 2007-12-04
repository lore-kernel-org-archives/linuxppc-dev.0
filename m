Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5E33DDEF6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:15:12 +1100 (EST)
Message-ID: <4755B54C.60504@pobox.com>
Date: Tue, 04 Dec 2007 15:15:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gianfar driver: eliminate compiler warnings and
	unnecessary macros
References: <20071202051245.8918.24063.stgit@trillian.secretlab.ca>
In-Reply-To: <20071202051245.8918.24063.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch eliminates the warning of unused return values when the driver
> registers it sysfs files.  Now the driver will print an error if it is
> unable to register the sysfs files.
> 
> It also eliminates the macros used to wrap the DEVICE_ATTR macro and the
> device_create_file function call.  The macros don't reduce the number of
> lines of source code in the file and the name munging makes is so that
> cscope and friends don't see the references to the functions.  It's better
> to just call the kernel API directly.
> 
> While we're at it, the DEVICE_ATTR instances have been moved down to
> be grouped with the functions they depend on.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  drivers/net/gianfar_sysfs.c |   50 ++++++++++++++++++++++---------------------
>  1 files changed, 25 insertions(+), 25 deletions(-)

applied #upstream
