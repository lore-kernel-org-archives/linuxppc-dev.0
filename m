Return-Path: <super.firetwister@googlemail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id 4E1C9DE105
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:37:48 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so2680377hsz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 03:37:45 -0700 (PDT)
Message-ID: <6a6049b80804100337m6ab33fd5wd3cf9524e7f6d721@mail.gmail.com>
Date: Thu, 10 Apr 2008 12:37:45 +0200
From: "M B" <super.firetwister@googlemail.com>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: ppc405ep emac driver loading problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I'm porting vanilla 2.6.25-rc8 (arch=powerpc) to a new board. UART is
already working in the kernel and Uboot with UART and ethernet is also
working.
But I can't get the emac driver (ibm_newemac) working under Linux.
On boot emac_init get's called and exits normally, but no probe or
open will get called and no network devices (except lo) are known to
the kernel.

Do I have to do something more, than adding the mals and emacs to the
device tree? I haven't seen any 40x or 44x board in the platforms
folder doing something special for the emac.

Any hints?

Regards

Markus
