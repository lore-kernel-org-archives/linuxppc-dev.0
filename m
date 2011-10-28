Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 841791007DF
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2011 03:40:48 +1100 (EST)
Date: Fri, 28 Oct 2011 18:37:06 +0200
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] Example to show use of uio pgprot
Message-ID: <20111028163706.GB27444@kroah.com>
References: <1319817030-23992-1-git-send-email-galak@kernel.crashing.org>
 <1319817030-23992-2-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319817030-23992-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, hjk@hansjkoch.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2011 at 10:50:30AM -0500, Kumar Gala wrote:
> ---
>  drivers/uio/uio_dpa.c |  200 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 200 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/uio/uio_dpa.c

You do realize this does not build, right?

thanks,

greg k-h
