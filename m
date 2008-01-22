Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 0BD38DDF01
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:25:49 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so593028anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 11:25:48 -0800 (PST)
Message-ID: <fa686aa40801221125v770cc3a5kdbc3284b781b55a8@mail.gmail.com>
Date: Tue, 22 Jan 2008 12:25:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joshua Williams" <joshua.williams@qlogic.com>
Subject: Re: [PATCH] Various new ibm405 DCRN #defines
In-Reply-To: <47952018.7050702@qlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47952018.7050702@qlogic.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/21/08, Joshua Williams <joshua.williams@qlogic.com> wrote:
>      Various new ibm405 DCRN #defines.
>
>      Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
> ---
>   arch/ppc/platforms/4xx/ibm405ep.h  |    3 +++
>   arch/ppc/platforms/4xx/ibm405gp.h  |    9 +++++++++
>   arch/ppc/platforms/4xx/ibm405gpr.h |    9 +++++++++
>   include/asm-ppc/ibm405.h           |   27 +++++++++++++++++++++++++++
>   4 files changed, 48 insertions(+), 0 deletions(-)

Changes like this should only be done in conjunction with
drivers/board support patches which actually use them.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
