Return-Path: <linus971@gmail.com>
Received: from mail-vb0-x234.google.com (mail-vb0-x234.google.com
 [IPv6:2607:f8b0:400c:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A99C2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 08:20:42 +1100 (EST)
Received: by mail-vb0-f52.google.com with SMTP id f12so3870689vbg.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Oct 2013 14:20:37 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1381180104.645.176.camel@pasglop>
References: <1381180104.645.176.camel@pasglop>
Date: Mon, 7 Oct 2013 14:20:36 -0700
Message-ID: <CA+55aFz72+ZeexmZbgW_jO4tAJaH6guMM=1SaDnomT2urwsuSA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/irq: Don't switch to irq stack from softirq stack
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@fr.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 7, 2013 at 2:08 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Linus, I don't have my git repo at hand right now and this is pretty
> urgent, can you apply it directly please ?

Done.

              Linus
