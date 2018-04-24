Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vsm945lgzF24D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:48:24 +1000 (AEST)
Received: by mail-oi0-x231.google.com with SMTP id y15-v6so10687315oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 11:48:24 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <87fu3spmy9.fsf@concordia.ellerman.id.au>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
 <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
 <CA+7wUswJoGnb50y8jbPfsi9ztCO1jZ+O4cirHtXc7gp7MXRm5Q@mail.gmail.com>
 <48cdb73c-f0c4-0c8a-19f5-8fce000e7050@c-s.fr>
 <CA+7wUszJzG4CyfO2_Tvmc_u9oMPxLQMaiP+HnhpEex6KCRgSYw@mail.gmail.com>
 <87fu3spmy9.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 24 Apr 2018 20:48:00 +0200
Message-ID: <CA+7wUsyO1QR6wzR9_Lj856m9OKOpvz4OjQKKY8SXe-iG+TbWRg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2018 at 5:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Mathieu Malaterre <malat@debian.org> writes:
>> On Wed, Apr 18, 2018 at 8:34 AM, Christophe LEROY
> ...
>>
>>> Can you also provide a copy of the messages you can see (prom_init ...) when
>>> boot is ok ?
>>
>> Hum. I've always been interested in seeing it also myself. Is there a
>> way to setup env to see those message (netconsole, delayed boot
>> messages ...) ? I never found a clear documentation on how to do that
>> on (closed) Apple hardware.
>
> If you see nothing after prom_init it usually indicates the kernel died
> very early in boot before it could find the console.
>
> The only option then is to enable one of the hard-coded EARLY_DEBUG
> options.

Right I see them now.

> I don't know which one works on a G4, maybe CONFIG_PPC_EARLY_DEBUG_BOOTX ?

Exactly !

> I assume it doesn't have a serial port.

- 56K Modem line (yes really!)
- 2 USB
- 1 Firewire

:(

> cheers
