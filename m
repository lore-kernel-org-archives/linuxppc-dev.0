Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09D6D1A0371
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 11:53:15 +1100 (AEDT)
Received: by mail-vc0-f171.google.com with SMTP id hy10so17123060vcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2015 17:53:12 -0700 (PDT)
Message-ID: <54FE4075.9020601@candw.ms>
Date: Mon, 09 Mar 2015 20:53:09 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>		
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>		
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>		
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>		
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>		
 <45dfe45093f.4ef2935f@smtp.gmail.com> <54ECCD8A.3060708@gmx.net>		
 <54ECDE7D.6070303@candw.ms> <54EDCD9E.5010104@candw.ms>		
 <54F6F081.9060007@candw.ms> <1425513154.32154.12.camel@ellerman.id.au>	
 <54F83ADC.9050203@candw.ms> <54FB22F0.1050506@candw.ms>
 <1425947411.19022.9.camel@ellerman.id.au>
In-Reply-To: <1425947411.19022.9.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/9/2015 8:30 PM, Michael Ellerman wrote:
> On Sat, 2015-03-07 at 12:10 -0400, Julian Margetson wrote:
>> With the latest commits
>>
>> [   29.960572] Unable to handle kernel paging request for data at address 0x00000008
>> [   29.974350] Faulting instruction address: 0xc04a4f44
>> [   32.012918] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   32.044900] PREEMPT Canyonlands
>> [   32.061504] Modules linked in: cfg80211 bnep rfcomm bluetooth
>> [   32.081023] CPU: 0 PID: 2087 Comm: Xorg Not tainted 4.0.0-rc2-Sam460ex #1
>> [   32.101802] task: ed6891a0 ti: ed606000 task.ti: ed606000
>> [   32.121175] NIP: c04a4f44 LR: c03e6a4c CTR: c03d7b6c
>> [   32.139995] REGS: ed607c50 TRAP: 0300   Not tainted  (4.0.0-rc2-Sam460ex)
>> [   32.160678] MSR: 00029000 <CE,EE,ME>  CR: 24004442  XER: 00000000
>> [   32.180922] DEAR: 00000008 ESR: 00000000
>> GPR00: c03e6a4c ed607d00 ed6891a0 eeac8000 00000000 0000000f ed607be8 00000000
>> GPR08: 0000f6a3 00000000 eeaae400 ed607cc0 24004422 b7ceeff8 b7d05c14 00000000
>> GPR16: 00000000 ffffffff 00000000 ed607e18 eeaae578 eebe2600 00000001 00004000
>> GPR24: 00004000 c075bd08 fffffff2 00000000 eeac8000 00000001 00000001 ee51a400
>> [   32.285496] NIP [c04a4f44] radeon_audio_enable+0x4/0x18
>> [   32.305509] LR [c03e6a4c] radeon_dvi_detect+0x388/0x3ac
>> [   32.325444] Call Trace:
>> [   32.342325] [ed607d00] [c03e6a4c] radeon_dvi_detect+0x388/0x3ac (unreliable)
>> [   32.364075] [ed607d30] [c0391cc4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
>> [   32.387631] [ed607d70] [c03adecc] drm_mode_getconnector+0xe4/0x330
>> [   32.408687] [ed607e10] [c03a0bbc] drm_ioctl+0x348/0x464
> You should send that to the Radeon maintainers.
>
> cheers
>
>
>
Thanks.

I have raised a couple of threads on the dri-devel@lists.freedesktop.org 
list .
