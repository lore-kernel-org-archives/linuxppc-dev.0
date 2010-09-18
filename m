Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 91DDBB70CC
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 11:21:04 +1000 (EST)
Received: by iwn37 with SMTP id 37so2778766iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 18:21:02 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Fri, 17 Sep 2010 20:20:31 -0500
Message-ID: <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2010 at 7:38 PM, Josh Boyer <jwboyer@gmail.com> wrote:

>> =A0unsigned long ppc_proc_freq;
>> =A0EXPORT_SYMBOL(ppc_proc_freq);
>> =A0unsigned long ppc_tb_freq;
>> +EXPORT_SYMBOL(ppc_tb_freq);
>
> EXPORT_SYMBOL_GPL probably, no?

I don't see any reason to limit it to GPL drivers.  Not only that, but
then we'll have this:

EXPORT_SYMBOL(ppc_proc_freq);
EXPORT_SYMBOL_GPL(ppc_tb_freq);

That just looks dumb.


--=20
Timur Tabi
Linux kernel developer at Freescale
