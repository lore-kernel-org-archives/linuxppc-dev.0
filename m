Return-Path: <rv@rasmusvillemoes.dk>
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com
 [IPv6:2a00:1450:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBDE71A0697
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 09:07:08 +1100 (AEDT)
Received: by wikq8 with SMTP id q8so4962421wik.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:07:05 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] kernel/cpu.c: eliminate some indirection
References: <1444144919-25143-1-git-send-email-linux@rasmusvillemoes.dk>
Date: Sun, 18 Oct 2015 00:07:03 +0200
In-Reply-To: <1444144919-25143-1-git-send-email-linux@rasmusvillemoes.dk>
 (Rasmus Villemoes's message of "Tue, 6 Oct 2015 17:21:53 +0200")
Message-ID: <877fmlno8o.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> v2: fix build failure on ppc, add acks.

Does anyone want to take these through their tree?

Rasmus
