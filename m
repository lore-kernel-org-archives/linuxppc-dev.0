Return-Path: <jwboyer@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6994CB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 05:57:58 +1100 (EST)
Received: by eaak11 with SMTP id k11so1245438eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 11:57:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
References: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
Date: Wed, 14 Mar 2012 14:57:53 -0400
Message-ID: <CA+5PVA4MdztrCk1QyiAZLit-2s807D85mrdmjA4w3gJjn=5p1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kdump support for PPC_47x
From: Josh Boyer <jwboyer@gmail.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
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

On Wed, Mar 14, 2012 at 6:22 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
> The following series implements Kexec/Kdump support for
> PPC_47x based platforms. Doesn't support SMP yet.
>
> I have tested these patches on simics simulator for ppc476.

Do you happen to know if these work in the IBM Instruction Set Simulator for
47x?  That would be the only commonly available 476 platform that I'm aware
of.

josh
