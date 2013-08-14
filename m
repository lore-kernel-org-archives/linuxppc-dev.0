Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB19D2C0203
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 04:56:30 +1000 (EST)
Received: by mail-la0-f48.google.com with SMTP id er20so697358lab.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 11:56:26 -0700 (PDT)
Message-ID: <520BD2E3.9080606@cogentembedded.com>
Date: Wed, 14 Aug 2013 22:56:35 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: Re: [PATCH RESEND 0/8] use platform_{get,set}_drvdata()
References: <5208E20A.4010306@huawei.com> <520AFB3F.2090006@huawei.com>
In-Reply-To: <520AFB3F.2090006@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 jg1.han@samsung.com, LKML <linux-kernel@vger.kernel.org>,
 Li Zefan <lizefan@huawei.com>, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2013 07:36 AM, Libo Chen wrote:

> We can use the wrapper functions platform_{get,set}_drvdata() instead of
> dev_{get,set}_drvdata() with &pdev->dev, it is convenient for user.
>
> Also, unnecessary dev_set_drvdata() is removed, because the driver core
> clears the driver data to NULL after device_release or on probe failure.

    Saying "also" in the changelog is usually a good sign that the patch 
should be split.

WBR, Sergei
