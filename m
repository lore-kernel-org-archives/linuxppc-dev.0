Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhgFb6CHGzDqvB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:28:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Qoriq P5020 PowerPC board doesn't boot with the latest git
 version anymore
In-Reply-To: <d8bf23c2-1805-a9c3-566d-74c0f28e88e8@xenosoft.de>
References: <ce2c842f-df48-6763-4626-adead5606acc@xenosoft.de>
 <3e4805a4-6114-205d-653b-ea6cd7fdc057@xenosoft.de>
 <8ed2edc7-a14b-35b3-86c1-a9995f41df84@xenosoft.de>
 <d8bf23c2-1805-a9c3-566d-74c0f28e88e8@xenosoft.de>
Date: Wed, 22 Nov 2017 22:28:51 +1100
Message-ID: <87ine23630.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Hi All,
>
> I created a patch for the git kernel today. (see attachment)
> Without the patch, the latest git kernel doesn't boot on my Cyrus Plus 
> board.

Hi Christian,

This doesn't make much sense.

Are you running any out of tree drivers or patches on this machine? Or
just 100% upstream.

I have a freescale p5020ds machine, but I don't have this Cyrus Plus
board.

What kernel config are you using, can you attach it?

When you say it "doesn't boot" what happens exactly? Do you see any
output at all?

cheers
