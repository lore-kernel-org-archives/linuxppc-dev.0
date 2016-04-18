Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpJMD3wmgzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 16:36:18 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id F2C78440D6F_714805CB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 06:36:12 +0000 (GMT)
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 874CD43E03A_714805BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 06:36:11 +0000 (GMT)
Received: by mail-qg0-f42.google.com with SMTP id v14so20564542qge.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 23:36:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460857857.32510.176.camel@buserror.net>
References: <1459950325-10327-1-git-send-email-alessio.bogani@elettra.eu>
 <CAPk1OjHEe+qcPYakD0BbikSkK+Dipj-9P2vatSceTcjMWYAPYg@mail.gmail.com>
 <1460857857.32510.176.camel@buserror.net>
Date: Mon, 18 Apr 2016 08:36:09 +0200
Message-ID: <CAPk1OjFrwn588U8mNXjmMtRcEV8+n1=w0Y-NBXhBz34mO-GLRg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] powerpc/fsl: Fix build of the dtb embedded kernel
 images
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

On 17 April 2016 at 03:50, Scott Wood <oss@buserror.net> wrote:
> On Fri, 2016-04-15 at 10:27 +0200, Alessio Igor Bogani wrote:
[...]
>> Any comments?
>
> Looks OK to me.

Thanks for review it. Follow a no-RFC version.

Ciao,
Alessio
