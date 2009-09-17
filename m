Return-Path: <PeterHuewe@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0D37DB7B6B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 10:45:25 +1000 (EST)
From: Peter Huewe <PeterHuewe@gmx.de>
To: Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH] char/hvc: adding __init macro to char/hvc_vio.c
Date: Thu, 17 Sep 2009 02:38:39 +0200
References: <200908202314.07443.PeterHuewe@gmx.de>
In-Reply-To: <200908202314.07443.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200909170238.40051.PeterHuewe@gmx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mike Frysinger <vapier@gentoo.org>,
	Nicolas Palix <npalix@diku.dk>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Thursday 20 August 2009 23:14:06 schrieb Peter H=FCwe:
> From: Peter Huewe <peterhuewe@gmx.de>
>
> Trivial patch which adds the __init/__exit macros to the module_init/
> module_exit functions of char/hvc_vio.c
>
> Please have a look at the small patch and either pull it through
> your tree, or please ack' it so Jiri can pull it through the trivial tree.
>
> linux version 2.6.31-rc6 - linus git tree, Do 20. Aug 22:26:06 CEST 2009
>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Hi Jiri,
this one got merged by Benjamin, so you can drop it from your queue :)
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D948c28fe3001f2c9d852dff2a0b2c69fe7cec91b


@Benjamin: Thanks for merging.

Regards,
Peter
