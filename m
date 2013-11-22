Return-Path: <htejun@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 433F52C011F
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 09:25:03 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id fb1so1913615pad.18
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 14:24:59 -0800 (PST)
MIME-Version: 1.0
Sender: htejun@gmail.com
In-Reply-To: <1385086116-10972-1-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <1385086116-10972-1-git-send-email-alistair@popple.id.au>
Date: Fri, 22 Nov 2013 17:24:59 -0500
Message-ID: <CAOS58YOTq2BHcc9hNWup35OBRYcW=auGN-F1ECGMkC+nvk9tUw@mail.gmail.com>
Subject: Re: [PATCH 1/8] IBM Akebono: Add support to AHCI platform driver
From: Tejun Heo <tj@kernel.org>
To: Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide <linux-ide@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Nov 21, 2013 at 9:08 PM, Alistair Popple <alistair@popple.id.au> wrote:
> The new IBM Akebono board has a PPC476GTR SoC with an AHCI compliant
> SATA controller. This patch adds a compatible property for the new SoC
> to the AHCI platform driver.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to libata/for-3.13-fixes w/ stable cc'd.

Thanks.

-- 
tejun
