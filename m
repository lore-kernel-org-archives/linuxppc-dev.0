Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 1AE6F2C02B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 08:22:44 +1100 (EST)
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 by muin.pair.com (Postfix) with ESMTPSA id C20C78FC2C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 16:22:41 -0500 (EST)
Received: by mail-oa0-f41.google.com with SMTP id i10so7189960oag.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2013 13:22:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359972962-9379-1-git-send-email-agust@denx.de>
References: <1359725305-23916-1-git-send-email-agust@denx.de>
 <1359972962-9379-1-git-send-email-agust@denx.de>
Date: Mon, 4 Feb 2013 15:22:40 -0600
Message-ID: <CAOZdJXUs=bj9USy2vUhWkhckq_DtpvFpbw+eY-Ooq6Q9S-mhYA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/512x: add function for chip select parameter
 configuration
From: Timur Tabi <timur@tabi.org>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 4, 2013 at 4:16 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Add ability to configure chip select (CS) parameters for devices
> that need different CS parameters setup after their configuration.
> I.e. an FPGA device on LP bus can require different CS parameters
> for its bus interface after loading firmware into it. A driver
> can easily reconfigure the LPC CS parameters using this function.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---

Acked-by: Timur Tabi <timur@tabi.org>

-- 
Timur Tabi
Linux kernel developer at Freescale
