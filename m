Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id D96B91A031D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 02:34:08 +1000 (AEST)
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
 by smtp.transmode.se (Postfix) with ESMTP id 6ABF11187047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 18:34:04 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: PCI not working in 4.1 for p2010rdb(Freescale) based board
Date: Fri, 14 Aug 2015 16:34:03 +0000
Message-ID: <1439570043.3120.214.camel@transmode.se>
References: <1439558152.3120.207.camel@transmode.se>
In-Reply-To: <1439558152.3120.207.camel@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-14 at 13:15 +0000, Joakim Tjernlund wrote:
> I upgraded our kernel for our custom p2010rdb based board from 3.4 to 4.1=
 and I cannot get the
> PCI controller to work, it is not initialized as can be seem by the below=
 dmesg fro 3.4 and 4.1.
> Sorry to say, PCI is not my cup of tea so I don't not know how to find th=
e culprit.
> I have checked what I can but nothing stands out and I would appreciate s=
ome help/pointers

Naturally I found the problem shortly after sending this :)
Stupid copy&paste error ...

    Jocke=
