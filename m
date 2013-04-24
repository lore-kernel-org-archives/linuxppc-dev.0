Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3369D2C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 16:40:20 +1000 (EST)
Message-ID: <51777E4F.9060405@windriver.com>
Date: Wed, 24 Apr 2013 14:40:15 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/1] usb: ehci-fsl: set INCR8 mode only on MPC512x
References: <1366772110-9620-1-git-send-email-tiejun.chen@windriver.com>
 <20130424075554.1ae85c65@crub>
In-Reply-To: <20130424075554.1ae85c65@crub>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2013 01:55 PM, Anatolij Gustschin wrote:
> On Wed, 24 Apr 2013 10:55:10 +0800
> Tiejun Chen <tiejun.chen@windriver.com> wrote:
>
>> commit 761bbcb7, "usb: ehci-fsl: set INCR8 mode for system bus interface
>> on MPC512x", introduced to fix one MPC5121e (M36P) Errata by setting
>> INCR8 mode for system bus interface on MPC512x, but we should make sure
>> this is only valid for MPC512x like other parts of this commit. Otherwise
>
> NAK. It is already only valid for MPC512x.
>
>> this would issue other platforms as abnormal without this similar Errata.
>
> This setting is in the ehci_fsl_mpc512x_drv_resume() function which is
> not called on other platforms.

Yes, I already notice this and also send a notification to ignore this improper 
patch immediately ;-)

Thanks,

Tiejun
