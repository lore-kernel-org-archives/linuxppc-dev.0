Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.179])
	by ozlabs.org (Postfix) with ESMTP id E0F08DDE33
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 00:27:07 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so1240484ika
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 07:27:06 -0700 (PDT)
Message-ID: <528646bc0704150727p1583132ck5455a36782e4dbcc@mail.gmail.com>
Date: Sun, 15 Apr 2007 08:27:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: Mr Grant Likely's New Patches for 2.6 Kernel and Xilinx FPGA (
	Virtex-4 & Virtex-2
In-Reply-To: <BAY115-W1269AFE45FDEDFDEB86A99B2530@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W1269AFE45FDEDFDEB86A99B2530@phx.gbl>
Cc: Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/15/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
> Hi
>
> - Are these patches going to be part of 2.6.22 kernel? so we should wait a little and then using 2.6.22 we will have builtin support for sys ace without applying any new patches?

I would *like* them to become part of 2.6.22, but that really depends
on how well they are received, and if Paull will pick up arch/ppc
patches.

> - Do we still new to apply the paulus patch to the main kernel so that we can have hard TEMAC support? Or you have a same program as sys ace for it?

No, I did not include TEMAC support.  However, I will publish my git
tree tomorrow which will include the TEMAC driver.

> - Actually As a beginner I could not understand what are the rest of the patches
> released by Grant, I understood that one is for sys ace , but the others? Do I
> really need to apply them to for example , my 2.6.20.4 kernel?

You don't need to if you've got a working solution.  But these patches
should make it easier to build a working virtex kernel when using
Linus' tree.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
