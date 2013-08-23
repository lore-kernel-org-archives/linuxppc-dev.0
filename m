Return-Path: <anton@scarybugs.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 186372C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 11:43:49 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id r10so39086pdi.28
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 18:43:47 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Thu, 22 Aug 2013 18:43:44 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH 1/3 V5] mmc:core: parse voltage from device-tree
Message-ID: <20130823014344.GA24803@teo>
References: <1376459171-21016-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1376459171-21016-1-git-send-email-Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, scottwood@freescale.com, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 14, 2013 at 01:46:11PM +0800, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the available voltage mask.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

Acked-by: Anton Vorontsov <anton@enomsg.org>

Thanks a lot!

Anton
