Return-Path: <timur.tabi@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id DCB3BB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Oct 2010 06:45:46 +1100 (EST)
Received: by yws5 with SMTP id 5so2686531yws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 12:45:42 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <2E0C184B35151B4690232FF6CFE53FE501569473@VIECLEX02.frequentis.frq>
References: <ActvZb6Wjf+X+L1bSaeyxpan+cSXVQ==>
	<2E0C184B35151B4690232FF6CFE53FE501569473@VIECLEX02.frequentis.frq>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 20 Oct 2010 14:45:11 -0500
Message-ID: <AANLkTin7UQQRjQazAVdcjiTyEmwUW5GsZ1Qkv9UOp4cZ@mail.gmail.com>
Subject: Re: [QUESTION] MPC8343 'internal only' DMA support
To: KRONSTORFER Horst <Horst.KRONSTORFER@frequentis.com>
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

On Tue, Oct 19, 2010 at 3:15 AM, KRONSTORFER Horst
<Horst.KRONSTORFER@frequentis.com> wrote:
> i assume the mpc8343 dma controllers ability to do internally controlled
> operations (csb/csb)
> is _not_ affected by deactivating externally controlled operations via
> pinmultiplexing in sicrl.
>
> am I correct?

Hmmm... maybe.  In general, if you want an external master for the DMA
controller, I think you need to enable that via various registers.  So
if you don't enable external master, you won't have one.

Does that answer your question?

-- 
Timur Tabi
Linux kernel developer at Freescale
