Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 3EA9BDDE11
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Apr 2008 06:24:51 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1157796anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Apr 2008 13:24:50 -0700 (PDT)
Message-ID: <fa686aa40804271324i71a93a1bv93ad278b960f0c9d@mail.gmail.com>
Date: Sun, 27 Apr 2008 14:24:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: dhlii@dlasys.net
Subject: Re: ARCH=ppc strncmp undefined
In-Reply-To: <4814D35C.9070608@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4814D35C.9070608@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Apr 27, 2008 at 1:26 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>     After pulling and rebasing to 2.6.25, I get  strncmp is undefined
>  when  I try to link the kernel.
>
>    I have not chased this down as  just added strncmp into
>  arch/ppc/lib/string.S
>
>     But I would guess this is a side effect of changes to accomidate
>  migration to ARCH=powerpc.
>     There appear to be a number of remaining arch/ppc BSP's that need
>  strncmp and therefore
>     will not build in 2.6.25.

There is a patch to fix this bug:

http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055094.html

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
