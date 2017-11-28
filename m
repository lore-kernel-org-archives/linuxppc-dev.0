Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymKqs5jQzzDrST
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 21:37:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Qoriq P5020 PowerPC board doesn't boot with the latest git
 version anymore
In-Reply-To: <ab5f9c39-e801-0c6c-15fb-c5b782ab10b7@xenosoft.de>
References: <ce2c842f-df48-6763-4626-adead5606acc@xenosoft.de>
 <3e4805a4-6114-205d-653b-ea6cd7fdc057@xenosoft.de>
 <8ed2edc7-a14b-35b3-86c1-a9995f41df84@xenosoft.de>
 <d8bf23c2-1805-a9c3-566d-74c0f28e88e8@xenosoft.de>
 <ab5f9c39-e801-0c6c-15fb-c5b782ab10b7@xenosoft.de>
Date: Tue, 28 Nov 2017 21:37:42 +1100
Message-ID: <87k1yazo21.fsf@concordia.ellerman.id.au>
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
> I compiled the latest git kernel today. Unfortunately my Varisys Cyrus 
> Plus board still doesn't boot with the latest git kernel.
>
> After that I patched the kernel source code with the spinlock patch and 
> compiled the kernel again. With the spinlock patch, the latest git 
> kernel boots without any problems.
>
> Please find attached the spinlock patch.

Can you remove the patch, and then build your kernel with
CONFIG_PREEMPT=n.

cheers
