Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EA4CAB70B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 03:26:09 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so1628939vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 08:26:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
 <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
Date: Wed, 23 Nov 2011 11:26:06 -0500
Message-ID: <CA+5PVA61uehBOLTx8J0pHeYD-RDsmm--iW==QvQ+q3SSC3u0kQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] [44x] Fix typo in KEXEC Kconfig dependency
From: Josh Boyer <jwboyer@gmail.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2011 at 12:41 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wro=
te:
> Kexec is not supported on 47x. 47x is a variant of 44x with slightly
> different MMU and SMP support. There was a typo in the Kconfig
> dependency for KEXEC. This patch fixes the same.
>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc: =A0 =A0 Kumar Gala <galak@kernel.crashing.org>
> Cc: =A0 =A0 Josh Boyer <jwboyer@gmail.com>
> Cc: =A0 =A0 linux ppc dev <linuxppc-dev@lists.ozlabs.org>

Ben already took this one for 3.2.  I should have added my Acked-by a while=
 ago.

josh
