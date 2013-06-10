Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A6C6D2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 03:00:12 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id tj12so2810704pac.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 10:00:09 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAJL_dMtUXSCe3Bm=D4aYaX9NwhnaPjVsY4O+f8U9h5-NV9i0=A@mail.gmail.com>
References: <alpine.DEB.2.00.1306100922530.21948@ayla.of.borg>
 <alpine.DEB.2.00.1306100924570.22024@ayla.of.borg>
 <CAJL_dMtUXSCe3Bm=D4aYaX9NwhnaPjVsY4O+f8U9h5-NV9i0=A@mail.gmail.com>
Date: Mon, 10 Jun 2013 19:00:09 +0200
Message-ID: <CAMuHMdWBCi165Mc=WNcbJ9WCQzconLb-drm1CSSrAxgkfYXkiQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.10-rc5
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Anca Emanuel <anca.emanuel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 10, 2013 at 4:37 PM, Anca Emanuel <anca.emanuel@gmail.com> wrote:
> The relevant maintainers do not get a copy of this.

I do hope the PPC maintainers do read linuxppc-dev@lists.ozlabs.org.

> On Mon, Jun 10, 2013 at 10:25 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, 10 Jun 2013, Geert Uytterhoeven wrote:
>>> JFYI, when comparing v3.10-rc5 to v3.10-rc4[3], the summaries are:
>>>   - build errors: +19/-10
>>> [1] http://kisskb.ellerman.id.au/kisskb/head/6308/ (all 120 configs)
>>
>>  + arch/powerpc/kernel/cacheinfo.c: error: 'associativity' may be used uninitialized in this function [-Werror=uninitialized]:  => 571:16
>>   + arch/powerpc/kernel/cacheinfo.c: error: 'size_kb' may be used uninitialized in this function [-Werror=uninitialized]:  => 522:16
>>   + arch/powerpc/kernel/pci_dn.c: error: 'ret' may be used uninitialized in this function [-Werror=uninitialized]:  => 97:8
>>   + arch/powerpc/kvm/book3s_32_mmu.c: error: 'sr' may be used uninitialized in this function [-Werror=uninitialized]:  => 63:2
>>   + arch/powerpc/kvm/book3s_64_mmu.c: error: 'slb' may be used uninitialized in this function [-Werror=uninitialized]:  => 485:3
>>   + arch/powerpc/mm/hash_native_64.c: error: 'a_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 67:31
>>   + arch/powerpc/platforms/cell/spufs/inode.c: error: incompatible types when assigning to type 'kgid_t' from type 'int':  => 628:16
>>   + arch/powerpc/platforms/cell/spufs/inode.c: error: incompatible types when assigning to type 'kuid_t' from type 'int':  => 623:16
>>   + arch/powerpc/platforms/pseries/msi.c: error: 'total' may be used uninitialized in this function [-Werror=uninitialized]:  => 320:24
>>   + arch/powerpc/platforms/pseries/pci.c: error: 'pcie_link_speed_stats' may be used uninitialized in this function [-Werror=uninitialized]:  => 150:31
>>
>> powerpc-randconfig
>>
>>> [3] http://kisskb.ellerman.id.au/kisskb/head/6290/ (all 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
