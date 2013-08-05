Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D6D4C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 04:32:16 +1000 (EST)
To: Peter LaDow <petela@gocougs.wsu.edu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Failure to detect PCI card
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
Date: Mon, 05 Aug 2013 20:32:09 +0200
Message-Id: <20130805183209.06686380495@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Peter LaDow,

In message <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com> you wrote:
> I have a PCI card (a Netgear FA331, vendor:device 100b:0020) that is
> failing to be detected by our PPC platform.  This device works just
> fine in a PC, and other cards work just fine in the same PCI slot (we
> have an Intel 82540EM based card that works).
> 
> But for some reason, neither u-boot nor the kernel detect this card.
> Any ideas why this might be?

Is there any chance that this card has some BIOS (like most graphic
adapters do) which needs to run to put the card into an operative
state (like by initializing any DRAM memory on the card)?  OK, I would
normally not expect such on a 10/100 PCI Ethernet network adapter, but
I don't know this card at all...

Do you know if this card works in any other non-x86 system at all?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Quote from a recent meeting:   "We are going to continue having these
meetings everyday until I find out why no work is getting done."
