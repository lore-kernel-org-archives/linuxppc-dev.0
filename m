Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id B4BAF2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 11:19:06 +1000 (EST)
Received: from mail-ve0-f180.google.com (mail-ve0-f180.google.com
 [209.85.128.180])
 by muin.pair.com (Postfix) with ESMTPSA id BDBE58FC37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 21:19:04 -0400 (EDT)
Received: by mail-ve0-f180.google.com with SMTP id jz11so4584748veb.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 18:19:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5248D94E.7080904@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
 <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
 <5248D94E.7080904@freescale.com>
Date: Mon, 30 Sep 2013 20:19:04 -0500
Message-ID: <CAOZdJXUS4QEnKv1MNi=7CFgSGhkSE6hSb=T0xY5o4NqRdN-mjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
From: Timur Tabi <timur@tabi.org>
To: Lian Minghuan-b31939 <B31939@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, Zang Roy-R61911 <r61911@freescale.com>,
 Timur Tabi <timur@tabi.org>, Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 29, 2013 at 8:52 PM, Lian Minghuan-b31939
<B31939@freescale.com> wrote:
>
> How about PCI_FSL_COMMON?

That's not any better.  The problem is that you have two symbols for
generic/common FSL PCI support.  Adding the word "common" does not
help.  You need to make the symbols distinct.  Either that, or merge
them into one symbol.
