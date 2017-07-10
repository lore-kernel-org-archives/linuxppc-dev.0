Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5pjC3NP3zDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 01:17:03 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id 16so13200421qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 08:17:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499697478.19784.42.camel@abdul.in.ibm.com>
References: <1499320823.19784.17.camel@abdul.in.ibm.com>
 <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
 <1499697478.19784.42.camel@abdul.in.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jul 2017 18:17:00 +0300
Message-ID: <CAHp75VdSgpviH9U1nh7HVL-t9kHHQeAdDSnAGjsXtFaXXTNnXQ@mail.gmail.com>
Subject: Re: Today's linux-next build fail on powerpc
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Luis Oliveira <Luis.Oliveira@synopsys.com>,
 linux-next <linux-next@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 5:37 PM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> On Fri, 2017-07-07 at 19:36 +0300, Andy Shevchenko wrote:
>> On Thu, Jul 6, 2017 at 9:00 AM, Abdul Haleem
>> <abdhalee@linux.vnet.ibm.com> wrote:
>> > next-20170705 fails to build on powerpc with below errors.
>> I had sent a fix yesterday. Had you chance to test it?

> drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit
> declaration of function
> =E2=80=98i2c_detect_slave_mode=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
>   if (i2c_detect_slave_mode(&pdev->dev))
>       ^
>   CC [M]  fs/jffs2/scan.o
>
> Please point me to the correct patch you are referring to ?

commit 8f1a357d41a22009150cf404b5aa5876efdb59b1

   i2c: Provide a stub for i2c_detect_slave_mode()

--=20
With Best Regards,
Andy Shevchenko
