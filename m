Return-Path: <olof@lixom.net>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 780D1B71C6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2011 07:30:54 +1100 (EST)
Received: by ywp31 with SMTP id 31so1456050ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2011 13:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20111021173302.GB27652@quad.lixom.net>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>
Date: Sat, 22 Oct 2011 13:30:50 -0700
Message-ID: <CAOesGMg_Q6M5fsN3BsROu3XpGZGiC1Wi+GD7ksOYFMNfn_wW0Q@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Olof Johansson <olof@lixom.net>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, Oct 21, 2011 at 10:33 AM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Oct 14, 2011 at 03:08:34PM -0700, tmarri@apm.com wrote:
>> From: Tirumala Marri <tmarri@apm.com>
>
> Overall this driver seems to be based on the IP vendor driver? It
> looks like a completely flexible driver that implements all possible
> combinations of everything.

After looking a little closer at the patch set, it seems that number
one thing you need to do is simplify the driver. A lot.

I suggest starting from scratch with a clean implementation, only
bringing in the pieces you need. Over time, if other vendors are using
other aspects of the same IP, they get to add those parts of the
driver when they need it.  Look at the dwc3 driver for comparison on
cleanliness, it's much cleaner than what you've posted.


-Olof
