Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x234.google.com (mail-lb0-x234.google.com
 [IPv6:2a00:1450:4010:c04::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5989D2C0101
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 02:52:23 +1000 (EST)
Received: by mail-lb0-f180.google.com with SMTP id a16so4933684lbj.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 09:52:18 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <1376274739.32100.149.camel@pasglop>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
 <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
 <520058E0.8080304@ovro.caltech.edu>
 <CAN8Q1EczGM+aQMPti+QdvUHHbsn=ARV7sKptXc5M7gvEFoDkKQ@mail.gmail.com>
 <1376274739.32100.149.camel@pasglop>
Date: Mon, 12 Aug 2013 09:52:17 -0700
Message-ID: <CAN8Q1Ef0B9uMD1K8LkMasTRghwABNK_pevOqSRSVM6s-Ypf5JA@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 David Hawkins <dwh@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 11, 2013 at 7:32 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Do that help with e1000 as well ? IE. A bad clock might have caused
> malfunctions of the DMA for example...

No, it didn't help with the e1000.  In fact, we have separate clocks
for the on-board components.  This particular case was with our
expansion slot having a crappy clock buffer driving the PCI slot.

I'm still digging into the e1000 driver trying to find something.  But
right now we are working on a replacement for the 82540 (which has
been EOL'd anyhow, so it needs to be done, we'd just prefer it be
later rather than sooner).

Thanks,
Pete
