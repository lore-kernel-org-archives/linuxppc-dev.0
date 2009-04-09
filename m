Return-Path: <a.beregalov@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id 3ADEBDE1AC
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 00:50:38 +1000 (EST)
Received: by ewy9 with SMTP id 9so678165ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Apr 2009 07:50:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C7C29031-E717-4D83-874A-DC0D1E12BA3D@kernel.crashing.org>
References: <C7C29031-E717-4D83-874A-DC0D1E12BA3D@kernel.crashing.org>
Date: Thu, 9 Apr 2009 18:50:35 +0400
Message-ID: <a4423d670904090750x38b0411al246b7b57fe50a24b@mail.gmail.com>
Subject: Re: converting fs_enet to net_device_ops
From: Alexander Beregalov <a.beregalov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>,
	David Miller <davem@davemloft.net>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/4/9 Kumar Gala <galak@kernel.crashing.org>:
> Can someone look at converting drivers/net/fs_enet over to the new
> net_device_ops.
>
> Dave,
>
> Are you willing to take such a patch in for .30? =C2=A0Otherwise we need =
to add a
> select COMPAT_NET_DEV_OPS in Kconfig for this driver (and any others that
> might not have been converted over). =C2=A0drivers/net/ibm_newemac/ is an=
other.

Hi
I did not this mail.
I have sent a patch for it.
http://patchwork.ozlabs.org/patch/25781/
