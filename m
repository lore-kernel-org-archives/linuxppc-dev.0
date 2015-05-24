Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4C151A0C96
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 19:19:46 +1000 (AEST)
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B2421402B6
 for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2015 19:19:45 +1000 (AEST)
Received: by yhom41 with SMTP id m41so15672953yho.1
 for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2015 02:19:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150524115704.4b8ea9aa@kryten>
References: <1431668830-22734-1-git-send-email-cyrilbur@gmail.com>
 <20150524115704.4b8ea9aa@kryten>
Date: Sun, 24 May 2015 12:19:42 +0300
Message-ID: <CAOJe8K1bzi8ru17UvwBOXM9Df1ztE_aLHKXd3oj3Pdf-xCRE0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/configs: merge pseries_defconfig and
 pseries_le_defconfig
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@au1.ibm.com>, Benjamin Herrenschmidt <benh@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/24/15, Anton Blanchard <anton@samba.org> wrote:
> Hi Cyril,
>
>> These two configs should be identical with the exception of big or
>> little endian
>>
>> The big endian version has XMON_DEFAULT turned on while the little
>> endian has XMON_DEFAULT not set. Enable XMON_DEFAULT for little
>> endian.
>
> I disabled it on the LE defconfig on purpose. In most cases we want to
> get the kernel back around and running again. I got sick of building a
> mainline kernel for a non development box and coming back to it stuck in
> xmon.
>
> Should we disable it by default and require developers who want xmon to
> set the config option, or use the xmon=on boot?

I think that it's a good idea to keep it disabled by default
>
> Anton
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
