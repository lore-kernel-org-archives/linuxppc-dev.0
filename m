Return-Path: <bobby.prani@gmail.com>
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com
 [IPv6:2a00:1450:4010:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 725CB1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 01:22:05 +1000 (EST)
Received: by mail-la0-f47.google.com with SMTP id s18so6172284lam.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Sep 2014 08:22:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANq1E4QbRLjCGr+PuHqKa6Kx_+4MTmbzd9V1RqrQFS3f5YoSag@mail.gmail.com>
References: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdV_naTfQOLwOshWq1Q15kSE39a8GWChsjt3RrWRcd6peg@mail.gmail.com>
 <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
 <CANq1E4SCnDjN5yetrgtaRNdvDr7xqGOm1BXz7dbGvX3mnsm-MA@mail.gmail.com>
 <54036090.1050104@gmail.com>
 <CANq1E4QbRLjCGr+PuHqKa6Kx_+4MTmbzd9V1RqrQFS3f5YoSag@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 1 Sep 2014 11:21:30 -0400
Message-ID: <CAJhHMCBOeLK-Z_96V_aAWBikS6tjrdYfj6_0w-9kSzQb=UJZsw@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Wire up three syscalls
To: David Herrmann <dh.herrmann@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: open list <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

On Mon, Sep 1, 2014 at 7:33 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>
> Nice catch. We changed 'flags' from u64 to "unsigned int" in the last
> revision of the series. Patch looks good, but I'd prefer using
> "unsigned int" as type, instead of __u32. Just to be consistent with
> the syscall interface. The return type of F_GET_SEALS is actually
> "int" and the MSB is reserved for signed error codes, so you can
> savely use "int r = fcntl(fd, F_GET_SEALS, 0)" in
> mfd_assert_get_seals().
>

OK. Should I send a new patch with these changes or do you have one
line up already?

-- 
Pranith
