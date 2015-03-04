Return-Path: <runaway@candw.ms>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E0AF1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 22:46:17 +1100 (AEDT)
Received: by mail-qa0-f49.google.com with SMTP id w8so32880738qac.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2015 03:46:15 -0800 (PST)
Message-ID: <54F6F081.9060007@candw.ms>
Date: Wed, 04 Mar 2015 07:46:09 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>
 <45dfe45093f.4ef2935f@smtp.gmail.com> <54ECCD8A.3060708@gmx.net>
 <54ECDE7D.6070303@candw.ms> <54EDCD9E.5010104@candw.ms>
In-Reply-To: <54EDCD9E.5010104@candw.ms>
Content-Type: multipart/alternative;
 boundary="------------060706050400080902070009"
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060706050400080902070009
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Still stuck.
Problem still exist with 4.0.0-rc2 and I cant finish the bisect.
Triggered when using HDMI. No problem when using DVI.

[   33.535692] Unable to handle kernel paging request for data at address 0x00000008
[   33.566786] Faulting instruction address: 0xc049db84
[   33.574188] Vector: 300 (Data Access) at [eeb13c20]
[   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
[   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
[   33.590429]     sp: eeb13cd0
[   33.593310]    msr: 29000
[   33.595931]    dar: 8
[   33.598207]  dsisr: 0
[   33.600480]   current = 0xeea93ac0
[   33.603885]     pid   = 2311, comm = Xorg
[   33.607922] enter ? for help
[   33.610806] [link register   ] c049e2f4 radeon_audio_detect+0x288/0x290
[   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 (unreliable)
[   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
[   33.630369] [eeb13d30] c038b9d4 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
[   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
[   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
[   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
[   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
[   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
[   33.671253] SP (bfa56d20) is in userspace
[   33.675263] mon>  <no input ...>
[   35.703835] Oops: Kernel access of bad area, sig: 11 [#1]
[   35.709554] PREEMPT Canyonlands
[   35.712876] Modules linked in: cfg80211 snd_ice1724 snd_hda_codec_hdmi snd_ak4113 snd_pt2258 snd_ak4114 snd_i2c snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_ac97_codec snd_hda_intel ac97_bus snd_hda_controller snd_rawmidi snd_hda_codec snd_seq_device snd_pcm snd_timer snd
[   35.738047] CPU: 0 PID: 2311 Comm: Xorg Not tainted 4.0.0-rc1-Sam460ex #1
[   35.745189] task: eea93ac0 ti: eeb12000 task.ti: eeb12000
[   35.750872] NIP: c049db84 LR: c049e2f4 CTR: 00000000
[   35.756098] REGS: eeb13c20 TRAP: 0300   Not tainted  (4.0.0-rc1-Sam460ex)
[   35.763241] MSR: 00029000 <CE,EE,ME>  CR: 24004422  XER: 20000000
[   35.769778] DEAR: 00000008 ESR: 00000000
GPR00: c049e254 eeb13cd0 eea93ac0 eaa84000 00000000 0000000f ee0532c0 000190d6
GPR08: eab6da00 00000000 00000000 eeb13cb0 28004422 b7a11ff4 b7a87a98 b7a87988
GPR16: 00000000 ffffffff 00000000 eeb13e18 eaa08194 eaa08178 00000001 00004000
GPR24: 00004000 c071cd28 fffffff2 00000000 eab6c000 eaa84000 eab6da00 eab80400
[   35.804302] NIP [c049db84] radeon_audio_enable+0x4/0x18
[   35.809799] LR [c049e2f4] radeon_audio_detect+0x288/0x290
[   35.815480] Call Trace:
[   35.818053] [eeb13cd0] [c049e254] radeon_audio_detect+0x1e8/0x290 (unreliable)
[   35.825694] [eeb13d00] [c03dfe7c] radeon_dvi_detect+0x388/0x3ac
[   35.831956] [eeb13d30] [c038b9d4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   35.841137] [eeb13d70] [c03a7670] drm_mode_getconnector+0xf4/0x334
[   35.847663] [eeb13e10] [c039a8c0] drm_ioctl+0x348/0x464
[   35.853183] [eeb13ed0] [c00d0ca0] do_vfs_ioctl+0x52c/0x6e8
[   35.858974] [eeb13f20] [c00d0e9c] SyS_ioctl+0x40/0x68
[   35.864307] [eeb13f40] [c000ab04] ret_from_syscall+0x0/0x3c
[   35.870196] --- interrupt: c01 at 0x6fb1b8dc
[   35.870196]     LR = 0x6fb1b800
[   35.877971] Instruction dump:
[   35.881106] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6


>
> On 2/24/2015 4:26 PM, Julian Margetson wrote:
>> Thanks
>>
>> after skipping several times :
>>
>> git bisect skip
>>
>> There are only 'skip'ped commits left to test.
>> The first bad commit could be any of:
>> b486e0e6d599b9ca8667fb9a7d49b7383ee963c7
>> eab3bbeffd152125ae0f90863b8e9bc8eef49423
>> 960cd9d4fef6dd9e235c0e5c0d4ed027f8a48025
>> f02ad907cd9e7fe3a6405d2d005840912f1ed258
>> 6a425c2a9b37ca3d2c37e3c1cdf973dba53eaa79
>> ee0a89cf3c2c550e6d877dda21dd2947afb90cb6
>> 92890583627ee2a0518e55b063fcff86826fef96
>> 95d6eb3b134e1826ed04cc92b224d93de13e281f
>> 9469244d869623e8b54d9f3d4d00737e377af273
>> We cannot bisect more!
>>
>>
>>
>> On 2/24/2015 3:14 PM, Gerhard Pircher wrote:
>>> Am 2015-02-24 um 12:08 schrieb Julian Margetson:
>>>> Problems with  the Gib bisect
>>>> Kernel wont compile after 10th bisect .
>>> You can try "git bisect skip" to select another commit for testing.
>>> Hopefully that one compiles fine then.
>>>
>>> Gerhard
>>>
>>>> drivers/built-in.o: In function `drm_mode_atomic_ioctl':
>>>> (.text+0x865dc): undefined reference to `__get_user_bad'
>>>> make: *** [vmlinux] Error 1
>>>> root@julian-VirtualBox:/usr/src/linux# git bisect log
>>>> git bisect start
>>>> # bad: [c517d838eb7d07bbe9507871fab3931deccff539] Linux 4.0-rc1
>>>> git bisect bad c517d838eb7d07bbe9507871fab3931deccff539
>>>> # good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
>>>> git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
>>>> # good: [02f1f2170d2831b3233e91091c60a66622f29e82] kernel.h: remove ancient __FUNCTION__ hack
>>>> git bisect good 02f1f2170d2831b3233e91091c60a66622f29e82
>>>> # bad: [796e1c55717e9a6ff5c81b12289ffa1ffd919b6f] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
>>>> git bisect bad 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f
>>>> # good: [9682ec9692e5ac11c6caebd079324e727b19e7ce] Merge tag 'driver-core-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>>>> git bisect good 9682ec9692e5ac11c6caebd079324e727b19e7ce
>>>> # good: [a9724125ad014decf008d782e60447c811391326] Merge tag 'tty-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>>>> git bisect good a9724125ad014decf008d782e60447c811391326
>>>> # good: [f43dff0ee00a259f524ce17ba4f8030553c66590] Merge tag 'drm-amdkfd-next-fixes-2015-01-25' of git://people.freedesktop.org/~gabbayo/linux into drm-next
>>>> git bisect good f43dff0ee00a259f524ce17ba4f8030553c66590
>>>> # bad: [cffe1e89dc9bf541a39d9287ced7c5addff07084] drm: sti: HDMI add audio infoframe
>>>> git bisect bad cffe1e89dc9bf541a39d9287ced7c5addff07084
>>>> # good: [2f5b4ef15c60bc5292a3f006c018acb3da53737b] Merge tag 'drm/tegra/for-3.20-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
>>>> git bisect good 2f5b4ef15c60bc5292a3f006c018acb3da53737b
>>>> # bad: [865844448ce80ccd714793e9ba4140d7ae214229] drm/udl: optimize udl_compress_hline16 (v2)
>>>> git bisect bad 865844448ce80ccd714793e9ba4140d7ae214229
>>>> # bad: [d47df63393ed81977e0f6435988d9cbd70c867f7] drm/panel: simple: Add AVIC TM070DDH03 panel support
>>>> git bisect bad d47df63393ed81977e0f6435988d9cbd70c867f7
>>>> # bad: [9469244d869623e8b54d9f3d4d00737e377af273] drm/atomic: Fix potential use of state after free
>>>> git bisect bad 9469244d869623e8b54d9f3d4d00737e377af273
>>>> root@julian-VirtualBox:/usr/src/linux#
>>>>
>>>>
>>>>


--------------060706050400080902070009
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Still stuck.<br>
    Problem still exist with 4.0.0-rc2 and I cant finish the bisect.<br>
    Triggered when using HDMI. No problem when using DVI.<br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">[   33.535692] Unable to handle kernel paging request for data at address 0x00000008
[   33.566786] Faulting instruction address: 0xc049db84
[   33.574188] Vector: 300 (Data Access) at [eeb13c20]
[   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
[   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
[   33.590429]     sp: eeb13cd0
[   33.593310]    msr: 29000
[   33.595931]    dar: 8
[   33.598207]  dsisr: 0
[   33.600480]   current = 0xeea93ac0
[   33.603885]     pid   = 2311, comm = Xorg
[   33.607922] enter ? for help
[   33.610806] [link register   ] c049e2f4 radeon_audio_detect+0x288/0x290
[   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 (unreliable)
[   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
[   33.630369] [eeb13d30] c038b9d4 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
[   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
[   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
[   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
[   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
[   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
[   33.671253] SP (bfa56d20) is in userspace
[   33.675263] mon&gt;  &lt;no input ...&gt;
[   35.703835] Oops: Kernel access of bad area, sig: 11 [#1]
[   35.709554] PREEMPT Canyonlands
[   35.712876] Modules linked in: cfg80211 snd_ice1724 snd_hda_codec_hdmi snd_ak4113 snd_pt2258 snd_ak4114 snd_i2c snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_ac97_codec snd_hda_intel ac97_bus snd_hda_controller snd_rawmidi snd_hda_codec snd_seq_device snd_pcm snd_timer snd
[   35.738047] CPU: 0 PID: 2311 Comm: Xorg Not tainted 4.0.0-rc1-Sam460ex #1
[   35.745189] task: eea93ac0 ti: eeb12000 task.ti: eeb12000
[   35.750872] NIP: c049db84 LR: c049e2f4 CTR: 00000000
[   35.756098] REGS: eeb13c20 TRAP: 0300   Not tainted  (4.0.0-rc1-Sam460ex)
[   35.763241] MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 24004422  XER: 20000000
[   35.769778] DEAR: 00000008 ESR: 00000000
GPR00: c049e254 eeb13cd0 eea93ac0 eaa84000 00000000 0000000f ee0532c0 000190d6
GPR08: eab6da00 00000000 00000000 eeb13cb0 28004422 b7a11ff4 b7a87a98 b7a87988
GPR16: 00000000 ffffffff 00000000 eeb13e18 eaa08194 eaa08178 00000001 00004000
GPR24: 00004000 c071cd28 fffffff2 00000000 eab6c000 eaa84000 eab6da00 eab80400
[   35.804302] NIP [c049db84] radeon_audio_enable+0x4/0x18
[   35.809799] LR [c049e2f4] radeon_audio_detect+0x288/0x290
[   35.815480] Call Trace:
[   35.818053] [eeb13cd0] [c049e254] radeon_audio_detect+0x1e8/0x290 (unreliable)
[   35.825694] [eeb13d00] [c03dfe7c] radeon_dvi_detect+0x388/0x3ac
[   35.831956] [eeb13d30] [c038b9d4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   35.841137] [eeb13d70] [c03a7670] drm_mode_getconnector+0xf4/0x334
[   35.847663] [eeb13e10] [c039a8c0] drm_ioctl+0x348/0x464
[   35.853183] [eeb13ed0] [c00d0ca0] do_vfs_ioctl+0x52c/0x6e8
[   35.858974] [eeb13f20] [c00d0e9c] SyS_ioctl+0x40/0x68
[   35.864307] [eeb13f40] [c000ab04] ret_from_syscall+0x0/0x3c
[   35.870196] --- interrupt: c01 at 0x6fb1b8dc
[   35.870196]     LR = 0x6fb1b800
[   35.877971] Instruction dump:
[   35.881106] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6</pre>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
	</style><br>
    <blockquote cite="mid:54EDCD9E.5010104@candw.ms" type="cite">
      <div class="moz-cite-prefix"> <br>
        On 2/24/2015 4:26 PM, Julian Margetson wrote:<br>
      </div>
      <blockquote cite="mid:54ECDE7D.6070303@candw.ms" type="cite">
        <meta content="text/html; charset=utf-8"
          http-equiv="Content-Type">
        <div class="moz-cite-prefix">Thanks<br>
          <br>
          after skipping several times :<br>
          <br>
          <meta http-equiv="content-type" content="text/html;
            charset=utf-8">
          <p style="margin-bottom: 0in; line-height: 100%">git bisect
            skip</p>
          <pre class="western">There are only 'skip'ped commits left to test.
The first bad commit could be any of:
b486e0e6d599b9ca8667fb9a7d49b7383ee963c7
eab3bbeffd152125ae0f90863b8e9bc8eef49423
960cd9d4fef6dd9e235c0e5c0d4ed027f8a48025
f02ad907cd9e7fe3a6405d2d005840912f1ed258
6a425c2a9b37ca3d2c37e3c1cdf973dba53eaa79
ee0a89cf3c2c550e6d877dda21dd2947afb90cb6
92890583627ee2a0518e55b063fcff86826fef96
95d6eb3b134e1826ed04cc92b224d93de13e281f
9469244d869623e8b54d9f3d4d00737e377af273
We cannot bisect more!</pre>
          <title></title>
          <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
          <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style><br>
          <br>
          <br>
          On 2/24/2015 3:14 PM, Gerhard Pircher wrote:<br>
        </div>
        <blockquote cite="mid:54ECCD8A.3060708@gmx.net" type="cite">
          <pre wrap="">Am 2015-02-24 um 12:08 schrieb Julian Margetson:
</pre>
          <blockquote type="cite">
            <pre wrap="">Problems with  the Gib bisect
Kernel wont compile after 10th bisect .
</pre>
          </blockquote>
          <pre wrap="">You can try "git bisect skip" to select another commit for testing.
Hopefully that one compiles fine then.

Gerhard

</pre>
          <blockquote type="cite">
            <pre wrap="">drivers/built-in.o: In function `drm_mode_atomic_ioctl':
(.text+0x865dc): undefined reference to `__get_user_bad'
make: *** [vmlinux] Error 1
root@julian-VirtualBox:/usr/src/linux# git bisect log
git bisect start
# bad: [c517d838eb7d07bbe9507871fab3931deccff539] Linux 4.0-rc1
git bisect bad c517d838eb7d07bbe9507871fab3931deccff539
# good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
# good: [02f1f2170d2831b3233e91091c60a66622f29e82] kernel.h: remove ancient __FUNCTION__ hack
git bisect good 02f1f2170d2831b3233e91091c60a66622f29e82
# bad: [796e1c55717e9a6ff5c81b12289ffa1ffd919b6f] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
git bisect bad 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f
# good: [9682ec9692e5ac11c6caebd079324e727b19e7ce] Merge tag 'driver-core-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect good 9682ec9692e5ac11c6caebd079324e727b19e7ce
# good: [a9724125ad014decf008d782e60447c811391326] Merge tag 'tty-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good a9724125ad014decf008d782e60447c811391326
# good: [f43dff0ee00a259f524ce17ba4f8030553c66590] Merge tag 'drm-amdkfd-next-fixes-2015-01-25' of git://people.freedesktop.org/~gabbayo/linux into drm-next
git bisect good f43dff0ee00a259f524ce17ba4f8030553c66590
# bad: [cffe1e89dc9bf541a39d9287ced7c5addff07084] drm: sti: HDMI add audio infoframe
git bisect bad cffe1e89dc9bf541a39d9287ced7c5addff07084
# good: [2f5b4ef15c60bc5292a3f006c018acb3da53737b] Merge tag 'drm/tegra/for-3.20-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
git bisect good 2f5b4ef15c60bc5292a3f006c018acb3da53737b
# bad: [865844448ce80ccd714793e9ba4140d7ae214229] drm/udl: optimize udl_compress_hline16 (v2)
git bisect bad 865844448ce80ccd714793e9ba4140d7ae214229
# bad: [d47df63393ed81977e0f6435988d9cbd70c867f7] drm/panel: simple: Add AVIC TM070DDH03 panel support
git bisect bad d47df63393ed81977e0f6435988d9cbd70c867f7
# bad: [9469244d869623e8b54d9f3d4d00737e377af273] drm/atomic: Fix potential use of state after free
git bisect bad 9469244d869623e8b54d9f3d4d00737e377af273
root@julian-VirtualBox:/usr/src/linux# 



</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------060706050400080902070009--
