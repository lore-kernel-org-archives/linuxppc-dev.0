Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E4032C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 02:58:27 +1000 (EST)
Date: Thu, 25 Apr 2013 11:58:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
 <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
In-Reply-To: <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
 (from segher@kernel.crashing.org on Thu Apr 25 10:31:51 2013)
Message-ID: <1366909096.30341.3@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Jia Hongtao <hongtao.jia@freescale.com>,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2013 10:31:51 AM, Segher Boessenkool wrote:
>> * Remove A variant of load instruction emulation
>=20
> Why is this?  You handle all other simple load insns, there is
> nothing special about LHA.  (I reviewed the V4 email thread, no
> reason for the chance is given there).

The LHA implementation in V5 was incorrect (didn't sign-extend).

-Scott=
