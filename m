Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B1E9B1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 16:07:10 +1100 (EST)
Received: by ggnk1 with SMTP id k1so2705572ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 22:07:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOesGMg_Q6M5fsN3BsROu3XpGZGiC1Wi+GD7ksOYFMNfn_wW0Q@mail.gmail.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>
 <CAOesGMg_Q6M5fsN3BsROu3XpGZGiC1Wi+GD7ksOYFMNfn_wW0Q@mail.gmail.com>
Date: Thu, 27 Oct 2011 10:37:04 +0530
Message-ID: <CAHM4w1nqP_OgsQ=NQ7yyd4cxHXyT8F1y7ULaCR2exLGg7YqqJg@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tmarri@apm.com, greg@kroah.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 23, 2011 at 2:00 AM, Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Fri, Oct 21, 2011 at 10:33 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Fri, Oct 14, 2011 at 03:08:34PM -0700, tmarri@apm.com wrote:
> >> From: Tirumala Marri <tmarri@apm.com>
> >
> > Overall this driver seems to be based on the IP vendor driver? It
> > looks like a completely flexible driver that implements all possible
> > combinations of everything.
>
> After looking a little closer at the patch set, it seems that number
> one thing you need to do is simplify the driver. A lot.
>
> I suggest starting from scratch with a clean implementation, only
> bringing in the pieces you need. Over time, if other vendors are using

Writing from scratch might take lot of time. I have used this driver
on a ARM based platform,
and found it stable after just  a bit modification , which I have
suggested in my earlier mails.
I have run all the test cases of standard testusb (except for
iscochronous), and have found
them working after the suggested modifications. So, I think that
driver is stable in a sense, and
can be included into mainline.

Regards
Pratyush


> other aspects of the same IP, they get to add those parts of the
> driver when they need it. =A0Look at the dwc3 driver for comparison on
> cleanliness, it's much cleaner than what you've posted.
>
>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
