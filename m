Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E13881A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 18:21:11 +1100 (AEDT)
Received: from [192.168.1.106] (ppp-93-104-82-252.dynamic.mnet-online.de
 [93.104.82.252]) by smtp.strato.de (RZmta 37.3 DYNA|AUTH)
 with ESMTPSA id L01087r2A6v5EZS
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 10 Mar 2015 07:57:05 +0100 (CET)
Message-ID: <54FE95C1.6090101@xenosoft.de>
Date: Tue, 10 Mar 2015 07:57:05 +0100
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base: Fix
 PowerPC address parsing hack
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
 <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
 <1425700921.4636.213.camel@kernel.crashing.org>
 <1425947283.19022.8.camel@ellerman.id.au>
 <CAOesGMhTr2ing8wLREJ0NqVkqD_eAb4L5=YgN37-MeJ3AX-NGA@mail.gmail.com>
In-Reply-To: <CAOesGMhTr2ing8wLREJ0NqVkqD_eAb4L5=YgN37-MeJ3AX-NGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2015 01:33 a.m., Olof Johansson wrote:

* Electra: First development/eval board. Funky USB on localbus, plenty
of PCI-e. Two GigE, one 10GigE XAUI. CompactFlash and IDE on localbus
too. Usually shipped with a PCI-e SATA card and a USB card.

* Chitra: Second edition dev/eval board. Moved SATA and USB on-board,
and removed some of the localbus hardware. Might have routed three
GigE out instead of 2, can't remember.

* Athena: Never released board with a smaller package chip, there's
only a few of these around. Can't comment too much on the specifics,
but it's similar to Chitra, and the silicon is the same.

----

@All

FYI:

* Nemo: Released as AmigaONE X1000. With co-processor: "Xena" 500 MHz 
XCore XS1-L2 124 SDS
and SB600 southbridge.

Linux support:

http://forum.hyperion-entertainment.biz/viewforum.php?f=35&sid=7849bde9bae455730f3b95ad207bb6e9
http://www.supertuxkart-amiga.de/amiga/x1000.html

Is still in stock: http://amigakit.leamancomputing.com/x1000/?webpage=buy.

It means you could buy a new PA6T system with active Linux support. It 
runs the latest kernel 4.0-rc3
and the new ubuntu MATE 15.04 PowerPC on this board.

>> Mine is running:
>>
>>    CFE version PAS-2.0.29 for ATHENA (64bit,MP,BE,PPC)
>>    Build Date: Mon Jun 30 11:47:25 PDT 2008 (mpl@mitch-1)
>>
>>
FYI: Nemo: CFE version PAS-2.0.30

Rgds,

Christian
