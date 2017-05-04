Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJW9n6WCYzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 20:15:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Linux User #330250 <linuxuser330250@gmx.net>
Subject: Re: WARNING: CPU: 0 PID: 1 at
 /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
 check_features+0x38/0x7c
In-Reply-To: <CA+7wUsyo5HEVrNFGaH0WGB5WTatX7R7t_s2XhcbZ3kSDsAh2hA@mail.gmail.com>
References: <CA+7wUsyo5HEVrNFGaH0WGB5WTatX7R7t_s2XhcbZ3kSDsAh2hA@mail.gmail.com>
Date: Thu, 04 May 2017 20:15:08 +1000
Message-ID: <878tmdyllf.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <mathieu.malaterre@gmail.com> writes:

> Hi all,
>
> Does this dmesg output speaks to anyone here (smp kernel):
>
>
> [    4.767389] ------------[ cut here ]------------
> [    4.774668] WARNING: CPU: 0 PID: 1 at
> /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
> check_features+0x38/0x7c

Is there anything prior to the "cut here" line?

cheers
