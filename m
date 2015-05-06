Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2EB51A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 17:32:03 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 06 May 2015 09:31:42 +0200
Message-ID: <4635229.bceBxngCoe@wuerfel>
In-Reply-To: <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
 <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "chris@printf.net" <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>,
 "patches@apm.com" <patches@apm.com>, Rob Herring <robherring2@gmail.com>,
 Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
> >> @@ -533,6 +567,16 @@
> >>                         interrupts = <0x0 0x4f 0x4>;
> >>                 };
> >>
> >> +               sdhc0: sdhc@1c000000 {
> >> +                       device_type = "sdhc";
> >
> > device_type generally should not be used (there are a few exceptions).
> 
> Okay !!
> 

While we're at it, please change sdhc@1c000000 to mmc@1c000000.
Even though Linux does not care, we try to use the standard device
names for consistency.

	Arnd
