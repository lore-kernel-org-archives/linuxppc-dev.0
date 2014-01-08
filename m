Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 09C9A2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 07:25:44 +1100 (EST)
Date: Wed, 8 Jan 2014 12:26:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
Message-ID: <20140108202613.GD8417@kroah.com>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
 Rob Herring <robh@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> This patch adds initial support for providing processor cache information
> to userspace through sysfs interface. This is based on x86 implementation
> and hence the interface is intended to be fully compatible.
> 
> A per-cpu array of cache information maintained is used mainly for
> sysfs-related book keeping.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/Makefile     |   2 +-
>  drivers/base/cacheinfo.c  | 296 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cacheinfo.h |  43 +++++++
>  3 files changed, 340 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/cacheinfo.c
>  create mode 100644 include/linux/cacheinfo.h

You are creating sysfs files, yet you didn't add Documentation/ABI/
information, which is required.  Please fix that.

greg k-h
