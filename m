Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com
 [IPv6:2a00:1450:400c:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3smzSP2RXXzDrTd
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Oct 2016 19:51:47 +1100 (AEDT)
Received: by mail-wm0-x22d.google.com with SMTP id f193so56622285wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Oct 2016 01:51:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUszQjtBHWkGSAUKtbv8yFrHLAQ-9aZZSOM-vmgJZw4VOww@mail.gmail.com>
References: <CA+7wUszQjtBHWkGSAUKtbv8yFrHLAQ-9aZZSOM-vmgJZw4VOww@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Sun, 2 Oct 2016 10:51:20 +0200
Message-ID: <CA+7wUsxFPKZQOYZ12f7uU7e6eSS6aTx8MfjrNZHPMMDUiys63g@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in
 /home/mathieu/tmp/linux-4.6.4/drivers/scsi/scsi_devinfo.c:458:21
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 1, 2016 at 3:43 PM, Mathieu Malaterre <malat@debian.org> wrote:
[...]
> [    1.443124] UBSAN: Undefined behaviour in
> /home/mathieu/tmp/linux-4.6.4/drivers/scsi/scsi_devinfo.c:458:21
[...]

Fixed by: https://lkml.org/lkml/2016/8/8/665

Sorry for the noise.
