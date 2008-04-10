Return-Path: <super.firetwister@googlemail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 7C34BDE116
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 23:03:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so726224anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 06:03:18 -0700 (PDT)
Message-ID: <6a6049b80804100603s335dedc2qfb213a899a0ebf39@mail.gmail.com>
Date: Thu, 10 Apr 2008 15:03:18 +0200
From: "M B" <super.firetwister@googlemail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: ppc405ep emac driver loading problem
In-Reply-To: <20080410065211.7befbfba@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <6a6049b80804100337m6ab33fd5wd3cf9524e7f6d721@mail.gmail.com>
	<20080410065211.7befbfba@zod.rchland.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 1:52 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

>  You have to call of_platform_bus_probe with the various bus types for
>  your board.  See the top few functions of:
>
>  arch/powerpc/platforms/40x/walnut.c

Well I did this, but I made a typo (plb4 instead of plb3).
So thanks a lot for making me recheck this section. I don't know how
long I would have searched for this else.

Regards

Markus
