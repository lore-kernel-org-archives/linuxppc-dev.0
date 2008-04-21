Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.250])
	by ozlabs.org (Postfix) with ESMTP id 9665EDE0AC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:16:48 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1158768hsz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 14:16:47 -0700 (PDT)
Message-ID: <fa686aa40804211416l5a366f3dl3d91acbea00b539f@mail.gmail.com>
Date: Mon, 21 Apr 2008 15:16:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
In-Reply-To: <00248a3c226d44aa352ebb69894183f4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
	<fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
	<5422E8EE-4AFA-491B-8920-BDEBF596FF00@kernel.crashing.org>
	<20080421182953.GB6111@ld0162-tx32.am.freescale.net>
	<00248a3c226d44aa352ebb69894183f4@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 3:10 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > Speaking of making it obvious, is it time to put a #warning in some
> > prominent arch/ppc header?
> >
>
>  The last time arch/ppc built for me (a few days ago), it got
>  535 warnings.  I don't think anyone would notice one more.
>  Also, whoever doesn't yet know arch/ppc will be going away
>  has been living under a rock for the last two years.

You say that as if it is an uncommon living condition.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
