Return-Path: <slightlyunconventional@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id BAFEBB6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 04:19:06 +1100 (EST)
Received: by wyb32 with SMTP id 32so3023177wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 10:19:04 -0700 (PDT)
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <72F25CD340E3C147B5A186012F8331E7CB6ECF@zin33exm20.fsl.freescale.net>
References: <1286879117-5616-1-git-send-email-harninder.rai@freescale.com>
	<04CFEB4E-DFA2-44AB-AD90-859A7D0691A8@kernel.crashing.org>
	<72F25CD340E3C147B5A186012F8331E7CB6ECF@zin33exm20.fsl.freescale.net>
Date: Tue, 12 Oct 2010 10:19:03 -0700
Message-ID: <AANLkTi=8q-8+ZR=unxZdhQQZsn33hte_VNEvZpE0uGgp@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: 85xx: add cache-sram support
From: Hollis Blanchard <hollis@penguinppc.org>
To: Rai Harninder-B01044 <B01044@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 12, 2010 at 10:02 AM, Rai Harninder-B01044
<B01044@freescale.com> wrote:
> Currently the design is that we divide the sram portion into 2 equal
> parts for AMP
> That was the part of initial requirement
> Do we want to remove that?

Why wouldn't you just pass different cache-sram-size/offset values to
each kernel?

-Hollis
