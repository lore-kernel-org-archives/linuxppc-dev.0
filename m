Return-Path: <olof@lixom.net>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BE412C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 07:54:23 +1100 (EST)
Received: by mail-ie0-f173.google.com with SMTP id e13so18932159iej.18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2013 12:54:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353912688-6649-1-git-send-email-olof@lixom.net>
References: <1353912688-6649-1-git-send-email-olof@lixom.net>
Date: Thu, 3 Jan 2013 12:54:20 -0800
Message-ID: <CAOesGMjE1xHVMwhA_Hv4BL5CGmuReuTTGmRfntmXQ5R90khSLA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pasemi: enable PRINTK_TIME in defconfig
From: Olof Johansson <olof@lixom.net>
To: benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 25, 2012 at 10:51 PM, Olof Johansson <olof@lixom.net> wrote:
> Enable PRINTK_TIME in pasemi_defconfig. Also regenerate it, it seems
> that a lot of options have moved around since last time savedefconfig
> was ran on it.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Ping?


-Olof
