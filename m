Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ADB31A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 16:51:45 +1000 (EST)
Message-ID: <1403074303.32307.5.camel@concordia>
Subject: Re: Kernel 3.15: Boot problems with a PA6T board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 18 Jun 2014 16:51:43 +1000
In-Reply-To: <5397060F.9010308@xenosoft.de>
References: <5366649E.4030102@xenosoft.de>
 <1399268891.4600.3.camel@concordia> <53720AAC.1000100@xenosoft.de>
 <1401107166.23096.1.camel@concordia> <53851AFA.5040504@xenosoft.de>
 <1401251015.5468.5.camel@concordia> <5385A3F4.8070004@xenosoft.de>
 <5385C7A3.1080508@xenosoft.de> <1401331711.4930.7.camel@concordia>
 <5389AEB6.4030500@xenosoft.de> <5389B686.7070305@xenosoft.de>
 <538A58D4.5090602@xenosoft.de> <5396E4D6.60306@xenosoft.de>
 <5397060F.9010308@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-10 at 15:20 +0200, Christian Zigotzky wrote:
> Hi All,
> 
> Could you help me to remove the changes of the PCI code, please? Or 
> which patches shall I remove to get the old PCI code?

Hi Christian,

Thanks for doing the bisect. It wasn't clear why that change was causing your
issue, so I guess we're a bit stuck.

Olof (on CC), was going to try and look at it when he got some spare time.
Please keep him on CC.

cheers
