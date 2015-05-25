Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 824A61A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 10:46:15 +1000 (AEST)
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F0BD2140E62
 for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2015 10:46:14 +1000 (AEST)
Received: by pdfh10 with SMTP id h10so58285061pdf.3
 for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2015 17:46:13 -0700 (PDT)
Message-ID: <1432514764.2912.4.camel@cyril>
Subject: Re: [PATCH 1/2] powerpc/configs: merge pseries_defconfig and
 pseries_le_defconfig
From: Cyril Bur <cyrilbur@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org, Paul
 Mackerras <paulus@au1.ibm.com>, Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Mon, 25 May 2015 10:46:04 +1000
In-Reply-To: <CAOJe8K1bzi8ru17UvwBOXM9Df1ztE_aLHKXd3oj3Pdf-xCRE0Q@mail.gmail.com>
References: <1431668830-22734-1-git-send-email-cyrilbur@gmail.com>
 <20150524115704.4b8ea9aa@kryten>
 <CAOJe8K1bzi8ru17UvwBOXM9Df1ztE_aLHKXd3oj3Pdf-xCRE0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-05-24 at 12:19 +0300, Denis Kirjanov wrote:
> On 5/24/15, Anton Blanchard <anton@samba.org> wrote:
> > Hi Cyril,
> >
> >> These two configs should be identical with the exception of big or
> >> little endian
> >>
> >> The big endian version has XMON_DEFAULT turned on while the little
> >> endian has XMON_DEFAULT not set. Enable XMON_DEFAULT for little
> >> endian.
> >
> > I disabled it on the LE defconfig on purpose. In most cases we want to
> > get the kernel back around and running again. I got sick of building a
> > mainline kernel for a non development box and coming back to it stuck in
> > xmon.
> >
> > Should we disable it by default and require developers who want xmon to
> > set the config option, or use the xmon=on boot?
> 
> I think that it's a good idea to keep it disabled by default

Sure, that behaviour makes sense since and the goal here is to have them
be the same, I'll resent the patch to go the other way and turn
XMON_DEFAULT off in big endian.

Thanks,

Cyril
> >
> > Anton
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
