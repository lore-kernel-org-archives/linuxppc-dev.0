Return-Path: <pladow@gmail.com>
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com
 [IPv6:2a00:1450:4010:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED0D82C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 09:14:36 +1000 (EST)
Received: by mail-la0-f42.google.com with SMTP id mf11so2556985lab.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 16:14:30 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
Date: Mon, 5 Aug 2013 16:14:29 -0700
Message-ID: <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 5, 2013 at 4:07 PM, Peter LaDow <petela@gocougs.wsu.edu> wrote:
> However, replacing the 82540 based card with either a 3com 3C905TXM or
> the Netgear FA331, there is no response on the 0x10 IDSEL line.  Thus
> it appears these cards are NOT responding to configuration reads.  I
> think I have to break out the scope and probe around for the 5V/3V.  I
> wouldn't think that the supplies are the issue since these are
> universal cards, and as I understand it either 3V3 _or_ 5V can be
> present, so these should work fine.  Yet they aren't responding to PCI
> configuration cycles.

A few more notes.  I tried a variety of other cards, such as a PCI
modem (WinMode, ack), a WinTV card, and a PCI based 802.11 card.  All
of them enumerate perfectly.

Perhaps it is a BIOS option ROM like you suggested earlier.  The
3c90xC reference manual I found
(http://people.freebsd.org/~wpaul/3Com/3c90xc.pdf) mentions an option
ROM (and there is an Atmel part stuffed).  I can't find any technical
information on the FA331 (yet), so I don't know about it.

But regardless, wouldn't enumeration have to occur before any option
ROM could even be used?

Thanks,
Pete
