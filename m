Return-Path: <chenyu105@gmail.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A24742C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Sep 2013 23:21:06 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id mc17so3705578pbc.32
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Sep 2013 06:21:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5222fab5.YEgPB+c3ScR2enom%wangshilong1991@gmail.com>
References: <5222fab5.YEgPB+c3ScR2enom%wangshilong1991@gmail.com>
Date: Sun, 1 Sep 2013 21:21:01 +0800
Message-ID: <CANHg-x5uVnPVjecMMvreLWPGE2yHBL9yfeNbwdS29Xh+wAKbBw@mail.gmail.com>
Subject: Re: [RFC, v1, 1/1] powerpc/85xx: Wakeup kexec smp slave cpus in
 second kernel
From: Yu Chen <chenyu105@gmail.com>
To: Wang Shilong <wangshilong1991@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: msm@freescale.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

thx, I think I've sent this patch using gmail web gui and got some
format problems, I'll try resend this patch tomorrow

2013/9/1 Wang Shilong <wangshilong1991@gmail.com>:
> Hello, Using checkpatch.pl, i get the following warnings(errors):
> ERROR: patch seems to be corrupt (line wrapped?)
> #108: FILE: :418:
> mpc85xx_smp_flush_dcache_kexec(struct kimage *image)
>
> ERROR: do not set execute permissions for source files
> #197: FILE: arch/powerpc/kernel/head_fsl_booke.S
>
> ERROR: do not set execute permissions for source files
> #217: FILE: arch/powerpc/kernel/misc_32.S
>
> ERROR: do not set execute permissions for source files
> #316: FILE: arch/powerpc/platforms/85xx/smp.c
>
> WARNING: externs should be avoided in .c files
> #329: FILE: arch/powerpc/platforms/85xx/smp.c:148:
> +extern void reserve_kexec_bootmem(unsigned long poll_phy, int size);
>
> WARNING: please, no spaces at the start of a line
> #336: FILE: arch/powerpc/platforms/85xx/smp.c:155:
> +    unsigned long kexec_poll_virt;$
>
> WARNING: please, no spaces at the start of a line
> #337: FILE: arch/powerpc/platforms/85xx/smp.c:156:
> +    unsigned long *kexec_magic_virt;$
>
> WARNING: please, no spaces at the start of a line
> #339: FILE: arch/powerpc/platforms/85xx/smp.c:158:
> +    if (!kexec_poll_phy ||$
>
> ERROR: code indent should use tabs where possible
> #340: FILE: arch/powerpc/platforms/85xx/smp.c:159:
> +            kexec_poll_phy >= __max_low_memory)$
>
> WARNING: please, no spaces at the start of a line
> #340: FILE: arch/powerpc/platforms/85xx/smp.c:159:
> +            kexec_poll_phy >= __max_low_memory)$
>
> ERROR: code indent should use tabs where possible
> #341: FILE: arch/powerpc/platforms/85xx/smp.c:160:
> +        return;$
>
> WARNING: please, no spaces at the start of a line
> #341: FILE: arch/powerpc/platforms/85xx/smp.c:160:
> +        return;$
>
> WARNING: please, no spaces at the start of a line
> #343: FILE: arch/powerpc/platforms/85xx/smp.c:162:
> +    kexec_poll_virt = (unsigned long)phys_to_virt(kexec_poll_phy);$
>
> WARNING: please, no spaces at the start of a line
> #344: FILE: arch/powerpc/platforms/85xx/smp.c:163:
> +    kexec_magic_virt = (unsigned long *)kexec_poll_virt;$
>
> WARNING: please, no spaces at the start of a line
> #346: FILE: arch/powerpc/platforms/85xx/smp.c:165:
> +    if (*kexec_magic_virt == KEXEC_MAGIC)$
>
> ERROR: code indent should use tabs where possible
> #347: FILE: arch/powerpc/platforms/85xx/smp.c:166:
> +        reserve_kexec_bootmem(kexec_poll_phy, KEXEC_RESERVE_LIMIT);$
>
> WARNING: please, no spaces at the start of a line
> #347: FILE: arch/powerpc/platforms/85xx/smp.c:166:
> +        reserve_kexec_bootmem(kexec_poll_phy, KEXEC_RESERVE_LIMIT);$
>
> WARNING: please, no spaces at the start of a line
> #355: FILE: arch/powerpc/platforms/85xx/smp.c:174:
> +    unsigned long  kexec_poll_virt;$
>
> WARNING: please, no spaces at the start of a line
> #356: FILE: arch/powerpc/platforms/85xx/smp.c:175:
> +    unsigned long *kexec_flag_virt;$
>
> WARNING: please, no spaces at the start of a line
> #357: FILE: arch/powerpc/platforms/85xx/smp.c:176:
> +    unsigned long *kexec_magic_virt;$
>
> WARNING: please, no spaces at the start of a line
> #358: FILE: arch/powerpc/platforms/85xx/smp.c:177:
> +    unsigned long *kexec_jump_virt;$
>
> WARNING: please, no spaces at the start of a line
> #361: FILE: arch/powerpc/platforms/85xx/smp.c:180:
> +    if (!kexec_poll_phy ||$
>
> ERROR: code indent should use tabs where possible
> #362: FILE: arch/powerpc/platforms/85xx/smp.c:181:
> +            kexec_poll_phy >= __max_low_memory)$
>
> WARNING: please, no spaces at the start of a line
> #362: FILE: arch/powerpc/platforms/85xx/smp.c:181:
> +            kexec_poll_phy >= __max_low_memory)$
>
> ERROR: code indent should use tabs where possible
> #363: FILE: arch/powerpc/platforms/85xx/smp.c:182:
> +        return -EBUSY;$
>
> WARNING: please, no spaces at the start of a line
> #363: FILE: arch/powerpc/platforms/85xx/smp.c:182:
> +        return -EBUSY;$
>
> WARNING: please, no spaces at the start of a line
> #365: FILE: arch/powerpc/platforms/85xx/smp.c:184:
> +    kexec_poll_virt = (unsigned long)phys_to_virt(kexec_poll_phy);$
>
> WARNING: please, no spaces at the start of a line
> #367: FILE: arch/powerpc/platforms/85xx/smp.c:186:
> +    kexec_magic_virt = (unsigned long *)kexec_poll_virt;$
>
> WARNING: please, no spaces at the start of a line
> #368: FILE: arch/powerpc/platforms/85xx/smp.c:187:
> +    kexec_flag_virt = (unsigned long *)kexec_poll_virt + 1;$
>
> WARNING: please, no spaces at the start of a line
> #369: FILE: arch/powerpc/platforms/85xx/smp.c:188:
> +    kexec_jump_virt = (unsigned long *)kexec_poll_virt + 2;$
>
> WARNING: please, no spaces at the start of a line
> #372: FILE: arch/powerpc/platforms/85xx/smp.c:191:
> +    if (*kexec_magic_virt == KEXEC_MAGIC) {$
>
> ERROR: code indent should use tabs where possible
> #373: FILE: arch/powerpc/platforms/85xx/smp.c:192:
> +        flush_dcache_range((ulong)kexec_poll_virt,$
>
> WARNING: please, no spaces at the start of a line
> #373: FILE: arch/powerpc/platforms/85xx/smp.c:192:
> +        flush_dcache_range((ulong)kexec_poll_virt,$
>
> ERROR: code indent should use tabs where possible
> #374: FILE: arch/powerpc/platforms/85xx/smp.c:193:
> +        (ulong)kexec_poll_virt + L1_CACHE_BYTES-1);$
>
> WARNING: please, no spaces at the start of a line
> #374: FILE: arch/powerpc/platforms/85xx/smp.c:193:
> +        (ulong)kexec_poll_virt + L1_CACHE_BYTES-1);$
>
> ERROR: code indent should use tabs where possible
> #375: FILE: arch/powerpc/platforms/85xx/smp.c:194:
> +        *kexec_jump_virt = (unsigned long)__early_start;$
>
> WARNING: please, no spaces at the start of a line
> #375: FILE: arch/powerpc/platforms/85xx/smp.c:194:
> +        *kexec_jump_virt = (unsigned long)__early_start;$
>
> ERROR: code indent should use tabs where possible
> #376: FILE: arch/powerpc/platforms/85xx/smp.c:195:
> +        mb();$
>
> WARNING: please, no spaces at the start of a line
> #376: FILE: arch/powerpc/platforms/85xx/smp.c:195:
> +        mb();$
>
> ERROR: code indent should use tabs where possible
> #377: FILE: arch/powerpc/platforms/85xx/smp.c:196:
> +        /*kick cpu[nr] up*/$
>
> ERROR: code indent should use tabs where possible
> #378: FILE: arch/powerpc/platforms/85xx/smp.c:197:
> +        *kexec_flag_virt = nr;$
>
> WARNING: please, no spaces at the start of a line
> #378: FILE: arch/powerpc/platforms/85xx/smp.c:197:
> +        *kexec_flag_virt = nr;$
>
> ERROR: code indent should use tabs where possible
> #379: FILE: arch/powerpc/platforms/85xx/smp.c:198:
> +        mb();$
>
> WARNING: please, no spaces at the start of a line
> #379: FILE: arch/powerpc/platforms/85xx/smp.c:198:
> +        mb();$
>
> ERROR: code indent should use tabs where possible
> #380: FILE: arch/powerpc/platforms/85xx/smp.c:199:
> +        flush_dcache_range((ulong)kexec_poll_virt,$
>
> WARNING: please, no spaces at the start of a line
> #380: FILE: arch/powerpc/platforms/85xx/smp.c:199:
> +        flush_dcache_range((ulong)kexec_poll_virt,$
>
> ERROR: code indent should use tabs where possible
> #381: FILE: arch/powerpc/platforms/85xx/smp.c:200:
> +        (ulong)kexec_poll_virt + L1_CACHE_BYTES-1);$
>
> WARNING: please, no spaces at the start of a line
> #381: FILE: arch/powerpc/platforms/85xx/smp.c:200:
> +        (ulong)kexec_poll_virt + L1_CACHE_BYTES-1);$
>
> ERROR: code indent should use tabs where possible
> #383: FILE: arch/powerpc/platforms/85xx/smp.c:202:
> +        return 0;$
>
> WARNING: please, no spaces at the start of a line
> #383: FILE: arch/powerpc/platforms/85xx/smp.c:202:
> +        return 0;$
>
> WARNING: please, no spaces at the start of a line
> #384: FILE: arch/powerpc/platforms/85xx/smp.c:203:
> +    }$
>
> WARNING: please, no spaces at the start of a line
> #385: FILE: arch/powerpc/platforms/85xx/smp.c:204:
> +    return -EBUSY;$
>
> WARNING: please, no spaces at the start of a line
> #396: FILE: arch/powerpc/platforms/85xx/smp.c:249:
> +    if (!mpc85xx_smp_kick_kexec_cpus(nr))$
>
> ERROR: code indent should use tabs where possible
> #397: FILE: arch/powerpc/platforms/85xx/smp.c:250:
> +        goto kexec_kick_done;$
>
> WARNING: please, no spaces at the start of a line
> #397: FILE: arch/powerpc/platforms/85xx/smp.c:250:
> +        goto kexec_kick_done;$
>
> WARNING: externs should be avoided in .c files
> #423: FILE: arch/powerpc/platforms/85xx/smp.c:345:
> +extern const unsigned int relocate_smp_cpu_size;
>
> ERROR: code indent should use tabs where possible
> #434: FILE: arch/powerpc/platforms/85xx/smp.c:353:
> +        mb();$
>
> WARNING: please, no spaces at the start of a line
> #434: FILE: arch/powerpc/platforms/85xx/smp.c:353:
> +        mb();$
>
> ERROR: code indent should use tabs where possible
> #436: FILE: arch/powerpc/platforms/85xx/smp.c:355:
> +        if (crash_shutdown) {$
>
> WARNING: please, no spaces at the start of a line
> #436: FILE: arch/powerpc/platforms/85xx/smp.c:355:
> +        if (crash_shutdown) {$
>
> WARNING: suspect code indent for conditional statements (8, 12)
> #436: FILE: arch/powerpc/platforms/85xx/smp.c:355:
> +        if (crash_shutdown) {
> +            /* loop forever */
>
> ERROR: code indent should use tabs where possible
> #437: FILE: arch/powerpc/platforms/85xx/smp.c:356:
> +            /* loop forever */$
>
> ERROR: code indent should use tabs where possible
> #438: FILE: arch/powerpc/platforms/85xx/smp.c:357:
> +            while (1)$
>
> WARNING: please, no spaces at the start of a line
> #438: FILE: arch/powerpc/platforms/85xx/smp.c:357:
> +            while (1)$
>
> ERROR: code indent should use tabs where possible
> #439: FILE: arch/powerpc/platforms/85xx/smp.c:358:
> +                ;$
>
> WARNING: please, no spaces at the start of a line
> #439: FILE: arch/powerpc/platforms/85xx/smp.c:358:
> +                ;$
>
> ERROR: code indent should use tabs where possible
> #440: FILE: arch/powerpc/platforms/85xx/smp.c:359:
> +        } else {$
>
> WARNING: please, no spaces at the start of a line
> #440: FILE: arch/powerpc/platforms/85xx/smp.c:359:
> +        } else {$
>
> ERROR: code indent should use tabs where possible
> #441: FILE: arch/powerpc/platforms/85xx/smp.c:360:
> +            while (!atomic_read(&kexec_ready_to_reboot))$
>
> WARNING: please, no spaces at the start of a line
> #441: FILE: arch/powerpc/platforms/85xx/smp.c:360:
> +            while (!atomic_read(&kexec_ready_to_reboot))$
>
> ERROR: code indent should use tabs where possible
> #442: FILE: arch/powerpc/platforms/85xx/smp.c:361:
> +                cpu_relax();$
>
> WARNING: please, no spaces at the start of a line
> #442: FILE: arch/powerpc/platforms/85xx/smp.c:361:
> +                cpu_relax();$
>
> ERROR: code indent should use tabs where possible
> #443: FILE: arch/powerpc/platforms/85xx/smp.c:362:
> +            /*flush destination*/$
>
> ERROR: code indent should use tabs where possible
> #444: FILE: arch/powerpc/platforms/85xx/smp.c:363:
> +            if (save_image)$
>
> WARNING: please, no spaces at the start of a line
> #444: FILE: arch/powerpc/platforms/85xx/smp.c:363:
> +            if (save_image)$
>
> ERROR: code indent should use tabs where possible
> #445: FILE: arch/powerpc/platforms/85xx/smp.c:364:
> +                mpc85xx_smp_flush_dcache_kexec(save_image, 1);$
>
> WARNING: please, no spaces at the start of a line
> #445: FILE: arch/powerpc/platforms/85xx/smp.c:364:
> +                mpc85xx_smp_flush_dcache_kexec(save_image, 1);$
>
> ERROR: code indent should use tabs where possible
> #447: FILE: arch/powerpc/platforms/85xx/smp.c:366:
> +            flush_icache_range(wait_code_buffer,$
>
> WARNING: please, no spaces at the start of a line
> #447: FILE: arch/powerpc/platforms/85xx/smp.c:366:
> +            flush_icache_range(wait_code_buffer,$
>
> ERROR: code indent should use tabs where possible
> #448: FILE: arch/powerpc/platforms/85xx/smp.c:367:
> +                wait_code_buffer + relocate_smp_cpu_size);$
>
> WARNING: please, no spaces at the start of a line
> #448: FILE: arch/powerpc/platforms/85xx/smp.c:367:
> +                wait_code_buffer + relocate_smp_cpu_size);$
>
> ERROR: code indent should use tabs where possible
> #449: FILE: arch/powerpc/platforms/85xx/smp.c:368:
> +            flush_dcache_range(wait_code_buffer,$
>
> WARNING: please, no spaces at the start of a line
> #449: FILE: arch/powerpc/platforms/85xx/smp.c:368:
> +            flush_dcache_range(wait_code_buffer,$
>
> ERROR: code indent should use tabs where possible
> #450: FILE: arch/powerpc/platforms/85xx/smp.c:369:
> +                wait_code_buffer + relocate_smp_cpu_size);$
>
> WARNING: please, no spaces at the start of a line
> #450: FILE: arch/powerpc/platforms/85xx/smp.c:369:
> +                wait_code_buffer + relocate_smp_cpu_size);$
>
> ERROR: code indent should use tabs where possible
> #452: FILE: arch/powerpc/platforms/85xx/smp.c:371:
> +            atomic_inc(&kexec_slave_finish);$
>
> WARNING: please, no spaces at the start of a line
> #452: FILE: arch/powerpc/platforms/85xx/smp.c:371:
> +            atomic_inc(&kexec_slave_finish);$
>
> ERROR: code indent should use tabs where possible
> #454: FILE: arch/powerpc/platforms/85xx/smp.c:373:
> +            ((void (*)(void)) wait_code_buffer)();$
>
> WARNING: please, no spaces at the start of a line
> #454: FILE: arch/powerpc/platforms/85xx/smp.c:373:
> +            ((void (*)(void)) wait_code_buffer)();$
>
> ERROR: code indent should use tabs where possible
> #455: FILE: arch/powerpc/platforms/85xx/smp.c:374:
> +            /* NOTREACHED */$
>
> ERROR: code indent should use tabs where possible
> #456: FILE: arch/powerpc/platforms/85xx/smp.c:375:
> +        }$
>
> WARNING: please, no spaces at the start of a line
> #456: FILE: arch/powerpc/platforms/85xx/smp.c:375:
> +        }$
>
> total: 39 errors, 53 warnings, 352 lines checked
>
> NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
>       scripts/cleanfile
>
> patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Thanks, Wang
>
> Notic: this is an automated generated by shell script
> Any problems please contact: wangshilong1991@gmail.com



-- 
Yu Chen
