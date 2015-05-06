Return-Path: <runaway@candw.ms>
Received: from mail-vn0-f51.google.com (mail-vn0-f51.google.com
 [209.85.216.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 058781A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 20:36:21 +1000 (AEST)
Received: by vnbg7 with SMTP id g7so333136vnb.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2015 03:36:18 -0700 (PDT)
Message-ID: <5549EE9F.3080907@candw.ms>
Date: Wed, 06 May 2015 06:36:15 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: No HDMI Audio with Radeon HD7750 on Acube Sam460ex AMCC powerpc
 460ex board
References: <54FC4F93.2000703@candw.ms>
 <CADnq5_PPbmwL8FpjHUCdjK4uVp8HGSZjJQeUgWTJpYzEpfrKiw@mail.gmail.com>
In-Reply-To: <CADnq5_PPbmwL8FpjHUCdjK4uVp8HGSZjJQeUgWTJpYzEpfrKiw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------040504010708030005070900"
Cc: linuxppc-dev@lists.ozlabs.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040504010708030005070900
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

git bisect good
38aef1549b18539eaecd804383a6ccb6588a9ce1 is the first bad commit
commit 38aef1549b18539eaecd804383a6ccb6588a9ce1
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Tue Apr 7 10:20:49 2015 -0400

     drm/radeon: only enable audio streams if the monitor supports it
     
     Selectively enable which packets we send based on monitor caps.
     
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
     Cc: stable@vger.kernel.org

:040000 040000 e27f98a4a15d2f30baf3ea92420112874b0b1c34 17af34604734b63ce30cfa3637fa1fa1fa1a38f4 M	drivers


Problems with HDMI audio connection continue.
Kernel 4.0.0 will not boot with HDMI connected only DVI. HD6670 & HD7750 
tested .
Kernel 4.1.0-rc1 same. HD7750 tested .
Kernel 4.1.0-rc2 will only boot if monitor connected with DVI to VGA 
adapter . HD7750 tested.

U-Boot 2010.06.05a (Jan 30 2012 - 16:06:56)

CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
        No Security/Kasumi support
        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
        Internal PCI arbiter enabled
        32 kB I-Cache 32 kB D-Cache
Board: Sam460ex, PCIe 4x + PCIe 1x
I2C:   ready
DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
PCI:   Bus Dev VenId DevId Class Int
         00  04  1095  3512  0104  00
         00  06  126f  0501  0380  00
PCIE0: successfully set as root-complex
         03  00  1412  1724  0401  ff
         02  00  1b21  1080  0604  00
PCIE1: successfully set as root-complex
         05  00  1002  683f  0300  ff
Net:   ppc_4xx_eth0
FPGA:  Revision 03 (2010-10-07)
SM502: found
VGA:   1
VESA:  OK

[    2.752985] Generic non-volatile memory driver v1.1
[    2.758430] Linux agpgart interface v0.103
[    2.762867] [drm] Initialized drm 1.1.0 20060810
[    2.767774] [drm] radeon kernel modesetting enabled.
[    2.773908] [drm] initializing kernel modesetting (VERDE 0x1002:0x683F 0x1545:0x7750).
[    2.782084] [drm] register mmio base: 0xe90000000
[    2.786859] [drm] register mmio size: 262144
[    3.123010] ATOM BIOS: C44501
[    3.126284] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    3.135213] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    3.142897] [drm] Detected VRAM RAM=1024M, BAR=256M
[    3.147791] [drm] RAM width 128bits DDR
[    3.151836] [TTM] Zone  kernel: Available graphics memory: 379234 kiB
[    3.158325] [TTM] Zone highmem: Available graphics memory: 1034594 kiB
[    3.164877] [TTM] Initializing pool allocator
[    3.169271] [TTM] Initializing DMA pool allocator
[    3.174101] [drm] radeon: 1024M of VRAM memory ready
[    3.179107] [drm] radeon: 1024M of GTT memory ready.
[    3.184146] [drm] Loading verde Microcode
[    3.188210] [drm] Internal thermal controller with fan control
[    3.194379] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.248227] [drm] radeon: dpm initialized
[    3.252458] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.264041] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.298301] [drm] PCIE GART of 1024M enabled (table at 0x0000000000277000).
[    3.305645] radeon 0001:81:00.0: WB enabled
[    3.309885] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffc01c00
[    3.320010] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffc01c04
[    3.330130] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffc01c08
[    3.340252] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffc01c0c
[    3.350374] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffc01c10
[    3.382285] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xf90b5a18
[    3.392430] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.399069] [drm] Driver supports precise vblank timestamp query.
[    3.405190] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
[    3.411071] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[    3.417195] [drm] radeon: irq initialized.
[    4.175889] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=0xCAFEDEAD)
[    4.184750] radeon 0001:81:00.0: disabling GPU acceleration
[    4.388914] [drm] Radeon Display Connectors
[    4.393501] [drm] Connector 0:
[    4.396624] [drm]   HDMI-A-1
[    4.399626] [drm]   HPD4
[    4.402211] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
[    4.409664] [drm]   Encoders:
[    4.412683] [drm]     DFP1: INTERNAL_UNIPHY2
[    4.416983] [drm] Connector 1:
[    4.420056] [drm]   DVI-I-1
[    4.422868] [drm]   HPD2
[    4.425423] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
[    4.432841] [drm]   Encoders:
[    4.435828] [drm]     DFP2: INTERNAL_UNIPHY
[    4.440029] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    4.560536] [drm] fb mappable at 0x80478000
[    4.564756] [drm] vram apper at 0x80000000
[    4.568867] [drm] size 8294400
[    4.571940] [drm] fb depth is 24
[    4.575186] [drm]    pitch is 7680
[    4.871678] Console: switching to colour frame buffer device 240x67
[    4.951862] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
[    4.958691] radeon 0001:81:00.0: registered panic notifier
[    4.968736] [drm] Initialized radeon 2.42.0 20080528 for 0001:81:00.0 on minor 0


[    7.448082] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
[    7.475388] snd_hda_intel 0001:81:00.1: Force to snoop mode by module option

[    7.709078] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0001:80/0001:80:00.0/0001:81:00.1/sound/card0/input2

[    7.927376] ALSA device list:
[    7.951820]   #0: HDA ATI HDMI at 0x90060000 irq 21



[   13.383835] systemd[1]: Starting Journal Service...
[   13.483427] systemd[1]: Started Journal Service.
[   16.842788] Adding 62564k swap on /dev/sda10.  Priority:-1 extents:1 across:62564k FS
[   18.516113] systemd-journald[1383]: Received request to flush runtime journal from PID 1
[   26.268157] eth0: link is up, 100 FDX, pause enabled
[   27.061114] Unable to handle kernel paging request for data at address 0x00000008
[   27.088902] Faulting instruction address: 0xc04ad114
[   27.093936] Vector: 300 (Data Access) at [ee7d3c30]
[   27.098817]     pc: c04ad114: radeon_audio_enable+0x4/0x18
[   27.104364]     lr: c04ad3c4: radeon_audio_detect+0xd4/0x104
[   27.110076]     sp: ee7d3ce0
[   27.112958]    msr: 29000
[   27.115580]    dar: 8
[   27.117853]  dsisr: 0
[   27.120129]   current = 0xea9a1d60
[   27.123532]     pid   = 2187, comm = Xorg
[   27.127564] enter ? for help
[   27.130454] [link register   ] c04ad3c4 radeon_audio_detect+0xd4/0x104
[   27.137029] [ee7d3ce0] c04ad390 radeon_audio_detect+0xa0/0x104 (unreliable)
[   27.144044] [ee7d3d00] c03eccd0 radeon_dvi_detect+0x390/0x3b4
[   27.149852] [ee7d3d30] c03977a0 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x448
[   27.158437] [ee7d3d70] c03b3a20 drm_mode_getconnector+0xe4/0x334
[   27.164504] [ee7d3e10] c03a68d8 drm_ioctl+0x374/0x458
[   27.169617] [ee7d3ed0] c00cfbfc do_vfs_ioctl+0x52c/0x6e8
[   27.174990] [ee7d3f20] c00cfdf8 SyS_ioctl+0x40/0x68
[   27.179921] [ee7d3f40] c000ab84 ret_from_syscall+0x0/0x3c
[   27.185379] --- Exception: c01 (System Call) at 1fe0925c
[   27.190727] SP (bff40610) is in userspace
[   27.194737] mon>  <no input ...>
[   29.213510] Oops: Kernel access of bad area, sig: 11 [#1]
[   29.219247] PREEMPT Canyonlands
[   29.222585] Modules linked in:
[   29.225829] CPU: 0 PID: 2187 Comm: Xorg Not tainted 4.1.0-rc2-Sam460ex #2
[   29.233006] task: ea9a1d60 ti: ee7d2000 task.ti: ee7d2000
[   29.238715] NIP: c04ad114 LR: c04ad3c4 CTR: c03eb324
[   29.243958] REGS: ee7d3c30 TRAP: 0300   Not tainted  (4.1.0-rc2-Sam460ex)
[   29.251127] MSR: 00029000 <CE,EE,ME>  CR: 24004422  XER: 00000000
[   29.257681] DEAR: 00000008 ESR: 00000000
GPR00: c04ad390 ee7d3ce0 ea9a1d60 eeafc000 00000000 00000000 c0740000 00000000
GPR08: 00000000 00000000 eeb18400 ee7d3ce0 24004444 20558ff4 20639b48 20633098
GPR16: 00000000 ffffffff 00000001 00000000 ee7d3e18 eeb18578 00000001 00004000
GPR24: 00004000 c074a1d8 c073e480 00000001 eeb654c0 eeafc000 eeb1ef00 00000000
[   29.292222] NIP [c04ad114] radeon_audio_enable+0x4/0x18
[   29.297744] LR [c04ad3c4] radeon_audio_detect+0xd4/0x104
[   29.303358] Call Trace:
[   29.305948] [ee7d3ce0] [c04ad390] radeon_audio_detect+0xa0/0x104 (unreliable)
[   29.313539] [ee7d3d00] [c03eccd0] radeon_dvi_detect+0x390/0x3b4
[   29.319822] [ee7d3d30] [c03977a0] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x448
[   29.329038] [ee7d3d70] [c03b3a20] drm_mode_getconnector+0xe4/0x334
[   29.335599] [ee7d3e10] [c03a68d8] drm_ioctl+0x374/0x458
[   29.341148] [ee7d3ed0] [c00cfbfc] do_vfs_ioctl+0x52c/0x6e8
[   29.346964] [ee7d3f20] [c00cfdf8] SyS_ioctl+0x40/0x68
[   29.352322] [ee7d3f40] [c000ab84] ret_from_syscall+0x0/0x3c
[   29.358232] --- interrupt: c01 at 0x1fe0925c
[   29.358232]     LR = 0x1fe09180
[   29.366040] Instruction dump:
[   29.369192] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6
[   29.377498] 4e800420 38600000 4e800020 81231cf0 <81290008> 2f890000 4d9e0020 7d2903a6
[   29.543328] ---[ end trace 0a55dcaf8c1fad23 ]---
[   29.547950]

Debian GNU/Linux 8 Sam460ex ttyS0

Sam460ex login:




On 3/8/2015 1:45 PM, Alex Deucher wrote:
> On Sun, Mar 8, 2015 at 9:33 AM, Julian Margetson<runaway@candw.ms>  wrote:
>> With Kernel 3.19  HDMI audio works ok with Radeon HD 6670 but not Radeon HD
>> 7750 on
>> Acube Sam460ex AMCC powerpc 460ex board.Also a problem with direct firmware
>> loading or the radeon firmware which loads ok for the Radeon HD 6670 .
> Make sure you've included the proper firmware images.  Note the case.
> We switched to a new firmware format for SI and newer and the firmware
> files names are now lower case (new verde_pfp.bin vs old
> VERDE_pfp.bin).  The older asics still use the old firmware format
> with the upper case names.
>
> As to the audio, I've never tested it on non-x86.  Make sure the hda
> audio driver is loaded correctly.
>
> Alex
>
>> [    2.561952] Linux agpgart interface v0.103
>> [    2.566290] [drm] Initialized drm 1.1.0 20060810
>> [    2.571164] [drm] radeon kernel modesetting enabled.
>> [    2.577230] [drm] initializing kernel modesetting (VERDE 0x1002:0x683F
>> 0x1545:0x7750).
>> [    2.585379] [drm] register mmio base: 0xe90000000
>> [    2.590143] [drm] register mmio size: 262144
>> [    2.925520] ATOM BIOS: C44501
>> [    2.928803] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 -
>> 0x000000003FFFFFFF (1024M used)
>> [    2.937725] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 -
>> 0x000000007FFFFFFF
>> [    2.945401] [drm] Detected VRAM RAM=1024M, BAR=256M
>> [    2.950294] [drm] RAM width 128bits DDR
>> [    2.954331] [TTM] Zone  kernel: Available graphics memory: 379212 kiB
>> [    2.960822] [TTM] Zone highmem: Available graphics memory: 1034572 kiB
>> [    2.967373] [TTM] Initializing pool allocator
>> [    2.971766] [TTM] Initializing DMA pool allocator
>> [    2.976604] [drm] radeon: 1024M of VRAM memory ready
>> [    2.981610] [drm] radeon: 1024M of GTT memory ready.
>> [    2.986651] [drm] Loading verde Microcode
>> [    2.990757] radeon 0001:81:00.0: Direct firmware load for
>> radeon/verde_pfp.bin failed with error -2
>> [    2.999908] radeon 0001:81:00.0: Direct firmware load for
>> radeon/verde_me.bin failed with error -2
>> [    3.008995] radeon 0001:81:00.0: Direct firmware load for
>> radeon/verde_ce.bin failed with error -2
>> [    3.018041] radeon 0001:81:00.0: Direct firmware load for
>> radeon/verde_rlc.bin failed with error -2
>> [    3.027184] radeon 0001:81:00.0: Direct firmware load for
>> radeon/verde_mc.bin failed with error -2
>> [    3.036203] [drm] radeon/VERDE_mc2.bin: 31500 bytes
>> [    3.041171] radeon 0001:81:00.0: Direct firmware load for
>> radeon/verde_smc.bin failed with error -2
>> [    3.050278] [drm] Internal thermal controller with fan control
>> [    3.056448] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
>> [    3.110566] [drm] radeon: dpm initialized
>> [    3.114788] [drm] GART: num cpu pages 262144, num gpu pages 262144
>> [    3.126445] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
>> [    3.171357] [drm] PCIE GART of 1024M enabled (table at
>> 0x0000000000277000).
>> [    3.178681] radeon 0001:81:00.0: WB enabled
>> [    3.182925] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr
>> 0x0000000040000c00 and cpu addr 0xffc01c00
>> [    3.193045] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr
>> 0x0000000040000c04 and cpu addr 0xffc01c04
>> [    3.203167] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr
>> 0x0000000040000c08 and cpu addr 0xffc01c08
>> [    3.213287] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr
>> 0x0000000040000c0c and cpu addr 0xffc01c0c
>> [    3.223409] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr
>> 0x0000000040000c10 and cpu addr 0xffc01c10
>> [    3.255059] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr
>> 0x0000000000075a18 and cpu addr 0xf90b5a18
>> [    3.265199] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [    3.271837] [drm] Driver supports precise vblank timestamp query.
>> [    3.277957] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
>> [    3.283833] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
>> [    3.289927] [drm] radeon: irq initialized.
>> [    4.047989] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed
>> (scratch(0x850C)=0xCAFEDEAD)
>> [    4.056845] radeon 0001:81:00.0: disabling GPU acceleration
>> [    4.261053] [drm] Radeon Display Connectors
>> [    4.265626] [drm] Connector 0:
>> [    4.268744] [drm]   HDMI-A-1
>> [    4.271735] [drm]   HPD4
>> [    4.274313] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c
>> 0x657c
>> [    4.281755] [drm]   Encoders:
>> [    4.284768] [drm]     DFP1: INTERNAL_UNIPHY2
>> [    4.289060] [drm] Connector 1:
>> [    4.292125] [drm]   DVI-I-1
>> [    4.294929] [drm]   HPD2
>> [    4.297476] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c
>> 0x656c
>> [    4.304894] [drm]   Encoders:
>> [    4.307872] [drm]     DFP2: INTERNAL_UNIPHY
>> [    4.312064] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
>> [    4.465445] [drm] fb mappable at 0x80478000
>> [    4.469662] [drm] vram apper at 0x80000000
>> [    4.473775] [drm] size 8294400
>> [    4.476840] [drm] fb depth is 24
>> [    4.480084] [drm]    pitch is 7680
>> [    4.759376] Console: switching to colour frame buffer device 240x67
>> [    4.838736] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
>> [    4.845560] radeon 0001:81:00.0: registered panic notifier
>> [    4.856007] [drm] Initialized radeon 2.40.0 20080528 for 0001:81:00.0 on
>> minor 0
>>
>> [   31.335598] [drm:dce6_audio_get_pin] *ERROR* No connected audio pins
>> found!
>>
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>>


--------------040504010708030005070900
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <pre class="western">git bisect good
38aef1549b18539eaecd804383a6ccb6588a9ce1 is the first bad commit
commit 38aef1549b18539eaecd804383a6ccb6588a9ce1
Author: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Date:   Tue Apr 7 10:20:49 2015 -0400

    drm/radeon: only enable audio streams if the monitor supports it
    
    Selectively enable which packets we send based on monitor caps.
    
    Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
    Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>

:040000 040000 e27f98a4a15d2f30baf3ea92420112874b0b1c34 17af34604734b63ce30cfa3637fa1fa1fa1a38f4 M	drivers</pre>
      <title></title>
      <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
      <meta name="created" content="00:00:00">
      <meta name="changed" content="00:00:00">
      <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style><br>
      Problems with HDMI audio connection continue.<br>
      Kernel 4.0.0 will not boot with HDMI connected only DVI. HD6670
      &amp; HD7750 tested .<br>
      Kernel 4.1.0-rc1 same. HD7750 tested .<br>
      Kernel 4.1.0-rc2 will only boot if monitor connected with DVI to
      VGA adapter . HD7750 tested.<br>
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <pre class="western">U-Boot 2010.06.05a (Jan 30 2012 - 16:06:56)

CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
       No Security/Kasumi support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       Internal PCI arbiter enabled
       32 kB I-Cache 32 kB D-Cache
Board: Sam460ex, PCIe 4x + PCIe 1x
I2C:   ready
DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
PCI:   Bus Dev VenId DevId Class Int
        00  04  1095  3512  0104  00
        00  06  126f  0501  0380  00
PCIE0: successfully set as root-complex
        03  00  1412  1724  0401  ff
        02  00  1b21  1080  0604  00
PCIE1: successfully set as root-complex
        05  00  1002  683f  0300  ff
Net:   ppc_4xx_eth0
FPGA:  Revision 03 (2010-10-07)
SM502: found
VGA:   1
VESA:  OK

[    2.752985] Generic non-volatile memory driver v1.1
[    2.758430] Linux agpgart interface v0.103
[    2.762867] [drm] Initialized drm 1.1.0 20060810
[    2.767774] [drm] radeon kernel modesetting enabled.
[    2.773908] [drm] initializing kernel modesetting (VERDE 0x1002:0x683F 0x1545:0x7750).
[    2.782084] [drm] register mmio base: 0xe90000000
[    2.786859] [drm] register mmio size: 262144
[    3.123010] ATOM BIOS: C44501
[    3.126284] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    3.135213] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    3.142897] [drm] Detected VRAM RAM=1024M, BAR=256M
[    3.147791] [drm] RAM width 128bits DDR
[    3.151836] [TTM] Zone  kernel: Available graphics memory: 379234 kiB
[    3.158325] [TTM] Zone highmem: Available graphics memory: 1034594 kiB
[    3.164877] [TTM] Initializing pool allocator
[    3.169271] [TTM] Initializing DMA pool allocator
[    3.174101] [drm] radeon: 1024M of VRAM memory ready
[    3.179107] [drm] radeon: 1024M of GTT memory ready.
[    3.184146] [drm] Loading verde Microcode
[    3.188210] [drm] Internal thermal controller with fan control
[    3.194379] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.248227] [drm] radeon: dpm initialized
[    3.252458] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.264041] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.298301] [drm] PCIE GART of 1024M enabled (table at 0x0000000000277000).
[    3.305645] radeon 0001:81:00.0: WB enabled
[    3.309885] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffc01c00
[    3.320010] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffc01c04
[    3.330130] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffc01c08
[    3.340252] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffc01c0c
[    3.350374] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffc01c10
[    3.382285] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xf90b5a18
[    3.392430] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.399069] [drm] Driver supports precise vblank timestamp query.
[    3.405190] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
[    3.411071] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[    3.417195] [drm] radeon: irq initialized.
[    4.175889] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=0xCAFEDEAD)
[    4.184750] radeon 0001:81:00.0: disabling GPU acceleration
[    4.388914] [drm] Radeon Display Connectors
[    4.393501] [drm] Connector 0:
[    4.396624] [drm]   HDMI-A-1
[    4.399626] [drm]   HPD4
[    4.402211] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
[    4.409664] [drm]   Encoders:
[    4.412683] [drm]     DFP1: INTERNAL_UNIPHY2
[    4.416983] [drm] Connector 1:
[    4.420056] [drm]   DVI-I-1
[    4.422868] [drm]   HPD2
[    4.425423] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
[    4.432841] [drm]   Encoders:
[    4.435828] [drm]     DFP2: INTERNAL_UNIPHY
[    4.440029] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    4.560536] [drm] fb mappable at 0x80478000
[    4.564756] [drm] vram apper at 0x80000000
[    4.568867] [drm] size 8294400
[    4.571940] [drm] fb depth is 24
[    4.575186] [drm]    pitch is 7680
[    4.871678] Console: switching to colour frame buffer device 240x67
[    4.951862] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
[    4.958691] radeon 0001:81:00.0: registered panic notifier
[    4.968736] [drm] Initialized radeon 2.42.0 20080528 for 0001:81:00.0 on minor 0


[    7.448082] snd_hda_intel 0001:81:00.1: enabling device (0000 -&gt; 0002)
[    7.475388] snd_hda_intel 0001:81:00.1: Force to snoop mode by module option

[    7.709078] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0001:80/0001:80:00.0/0001:81:00.1/sound/card0/input2

[    7.927376] ALSA device list:
[    7.951820]   #0: HDA ATI HDMI at 0x90060000 irq 21



[   13.383835] systemd[1]: Starting Journal Service...
[   13.483427] systemd[1]: Started Journal Service.
[   16.842788] Adding 62564k swap on /dev/sda10.  Priority:-1 extents:1 across:62564k FS
[   18.516113] systemd-journald[1383]: Received request to flush runtime journal from PID 1
[   26.268157] eth0: link is up, 100 FDX, pause enabled
[   27.061114] Unable to handle kernel paging request for data at address 0x00000008
[   27.088902] Faulting instruction address: 0xc04ad114
[   27.093936] Vector: 300 (Data Access) at [ee7d3c30]
[   27.098817]     pc: c04ad114: radeon_audio_enable+0x4/0x18
[   27.104364]     lr: c04ad3c4: radeon_audio_detect+0xd4/0x104
[   27.110076]     sp: ee7d3ce0
[   27.112958]    msr: 29000
[   27.115580]    dar: 8
[   27.117853]  dsisr: 0
[   27.120129]   current = 0xea9a1d60
[   27.123532]     pid   = 2187, comm = Xorg
[   27.127564] enter ? for help
[   27.130454] [link register   ] c04ad3c4 radeon_audio_detect+0xd4/0x104
[   27.137029] [ee7d3ce0] c04ad390 radeon_audio_detect+0xa0/0x104 (unreliable)
[   27.144044] [ee7d3d00] c03eccd0 radeon_dvi_detect+0x390/0x3b4
[   27.149852] [ee7d3d30] c03977a0 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x448
[   27.158437] [ee7d3d70] c03b3a20 drm_mode_getconnector+0xe4/0x334
[   27.164504] [ee7d3e10] c03a68d8 drm_ioctl+0x374/0x458
[   27.169617] [ee7d3ed0] c00cfbfc do_vfs_ioctl+0x52c/0x6e8
[   27.174990] [ee7d3f20] c00cfdf8 SyS_ioctl+0x40/0x68
[   27.179921] [ee7d3f40] c000ab84 ret_from_syscall+0x0/0x3c
[   27.185379] --- Exception: c01 (System Call) at 1fe0925c
[   27.190727] SP (bff40610) is in userspace
[   27.194737] mon&gt;  &lt;no input ...&gt;
[   29.213510] Oops: Kernel access of bad area, sig: 11 [#1]
[   29.219247] PREEMPT Canyonlands
[   29.222585] Modules linked in:
[   29.225829] CPU: 0 PID: 2187 Comm: Xorg Not tainted 4.1.0-rc2-Sam460ex #2
[   29.233006] task: ea9a1d60 ti: ee7d2000 task.ti: ee7d2000
[   29.238715] NIP: c04ad114 LR: c04ad3c4 CTR: c03eb324
[   29.243958] REGS: ee7d3c30 TRAP: 0300   Not tainted  (4.1.0-rc2-Sam460ex)
[   29.251127] MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 24004422  XER: 00000000
[   29.257681] DEAR: 00000008 ESR: 00000000 
GPR00: c04ad390 ee7d3ce0 ea9a1d60 eeafc000 00000000 00000000 c0740000 00000000 
GPR08: 00000000 00000000 eeb18400 ee7d3ce0 24004444 20558ff4 20639b48 20633098 
GPR16: 00000000 ffffffff 00000001 00000000 ee7d3e18 eeb18578 00000001 00004000 
GPR24: 00004000 c074a1d8 c073e480 00000001 eeb654c0 eeafc000 eeb1ef00 00000000 
[   29.292222] NIP [c04ad114] radeon_audio_enable+0x4/0x18
[   29.297744] LR [c04ad3c4] radeon_audio_detect+0xd4/0x104
[   29.303358] Call Trace:
[   29.305948] [ee7d3ce0] [c04ad390] radeon_audio_detect+0xa0/0x104 (unreliable)
[   29.313539] [ee7d3d00] [c03eccd0] radeon_dvi_detect+0x390/0x3b4
[   29.319822] [ee7d3d30] [c03977a0] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x448
[   29.329038] [ee7d3d70] [c03b3a20] drm_mode_getconnector+0xe4/0x334
[   29.335599] [ee7d3e10] [c03a68d8] drm_ioctl+0x374/0x458
[   29.341148] [ee7d3ed0] [c00cfbfc] do_vfs_ioctl+0x52c/0x6e8
[   29.346964] [ee7d3f20] [c00cfdf8] SyS_ioctl+0x40/0x68
[   29.352322] [ee7d3f40] [c000ab84] ret_from_syscall+0x0/0x3c
[   29.358232] --- interrupt: c01 at 0x1fe0925c
[   29.358232]     LR = 0x1fe09180
[   29.366040] Instruction dump:
[   29.369192] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6 
[   29.377498] 4e800420 38600000 4e800020 81231cf0 &lt;81290008&gt; 2f890000 4d9e0020 7d2903a6 
[   29.543328] ---[ end trace 0a55dcaf8c1fad23 ]---
[   29.547950] 

Debian GNU/Linux 8 Sam460ex ttyS0

Sam460ex login: </pre>
      <title></title>
      <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
      <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% </style><br>
      <br>
      <br>
      On 3/8/2015 1:45 PM, Alex Deucher wrote:<br>
    </div>
    <blockquote
cite="mid:CADnq5_PPbmwL8FpjHUCdjK4uVp8HGSZjJQeUgWTJpYzEpfrKiw@mail.gmail.com"
      type="cite">
      <pre wrap="">On Sun, Mar 8, 2015 at 9:33 AM, Julian Margetson <a class="moz-txt-link-rfc2396E" href="mailto:runaway@candw.ms">&lt;runaway@candw.ms&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">With Kernel 3.19  HDMI audio works ok with Radeon HD 6670 but not Radeon HD
7750 on
Acube Sam460ex AMCC powerpc 460ex board.Also a problem with direct firmware
loading or the radeon firmware which loads ok for the Radeon HD 6670 .
</pre>
      </blockquote>
      <pre wrap="">Make sure you've included the proper firmware images.  Note the case.
We switched to a new firmware format for SI and newer and the firmware
files names are now lower case (new verde_pfp.bin vs old
VERDE_pfp.bin).  The older asics still use the old firmware format
with the upper case names.

As to the audio, I've never tested it on non-x86.  Make sure the hda
audio driver is loaded correctly.

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="">[    2.561952] Linux agpgart interface v0.103
[    2.566290] [drm] Initialized drm 1.1.0 20060810
[    2.571164] [drm] radeon kernel modesetting enabled.
[    2.577230] [drm] initializing kernel modesetting (VERDE 0x1002:0x683F
0x1545:0x7750).
[    2.585379] [drm] register mmio base: 0xe90000000
[    2.590143] [drm] register mmio size: 262144
[    2.925520] ATOM BIOS: C44501
[    2.928803] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 -
0x000000003FFFFFFF (1024M used)
[    2.937725] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 -
0x000000007FFFFFFF
[    2.945401] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.950294] [drm] RAM width 128bits DDR
[    2.954331] [TTM] Zone  kernel: Available graphics memory: 379212 kiB
[    2.960822] [TTM] Zone highmem: Available graphics memory: 1034572 kiB
[    2.967373] [TTM] Initializing pool allocator
[    2.971766] [TTM] Initializing DMA pool allocator
[    2.976604] [drm] radeon: 1024M of VRAM memory ready
[    2.981610] [drm] radeon: 1024M of GTT memory ready.
[    2.986651] [drm] Loading verde Microcode
[    2.990757] radeon 0001:81:00.0: Direct firmware load for
radeon/verde_pfp.bin failed with error -2
[    2.999908] radeon 0001:81:00.0: Direct firmware load for
radeon/verde_me.bin failed with error -2
[    3.008995] radeon 0001:81:00.0: Direct firmware load for
radeon/verde_ce.bin failed with error -2
[    3.018041] radeon 0001:81:00.0: Direct firmware load for
radeon/verde_rlc.bin failed with error -2
[    3.027184] radeon 0001:81:00.0: Direct firmware load for
radeon/verde_mc.bin failed with error -2
[    3.036203] [drm] radeon/VERDE_mc2.bin: 31500 bytes
[    3.041171] radeon 0001:81:00.0: Direct firmware load for
radeon/verde_smc.bin failed with error -2
[    3.050278] [drm] Internal thermal controller with fan control
[    3.056448] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.110566] [drm] radeon: dpm initialized
[    3.114788] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.126445] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.171357] [drm] PCIE GART of 1024M enabled (table at
0x0000000000277000).
[    3.178681] radeon 0001:81:00.0: WB enabled
[    3.182925] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr
0x0000000040000c00 and cpu addr 0xffc01c00
[    3.193045] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr
0x0000000040000c04 and cpu addr 0xffc01c04
[    3.203167] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr
0x0000000040000c08 and cpu addr 0xffc01c08
[    3.213287] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr
0x0000000040000c0c and cpu addr 0xffc01c0c
[    3.223409] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr
0x0000000040000c10 and cpu addr 0xffc01c10
[    3.255059] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr
0x0000000000075a18 and cpu addr 0xf90b5a18
[    3.265199] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.271837] [drm] Driver supports precise vblank timestamp query.
[    3.277957] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
[    3.283833] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[    3.289927] [drm] radeon: irq initialized.
[    4.047989] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed
(scratch(0x850C)=0xCAFEDEAD)
[    4.056845] radeon 0001:81:00.0: disabling GPU acceleration
[    4.261053] [drm] Radeon Display Connectors
[    4.265626] [drm] Connector 0:
[    4.268744] [drm]   HDMI-A-1
[    4.271735] [drm]   HPD4
[    4.274313] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c
0x657c
[    4.281755] [drm]   Encoders:
[    4.284768] [drm]     DFP1: INTERNAL_UNIPHY2
[    4.289060] [drm] Connector 1:
[    4.292125] [drm]   DVI-I-1
[    4.294929] [drm]   HPD2
[    4.297476] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c
0x656c
[    4.304894] [drm]   Encoders:
[    4.307872] [drm]     DFP2: INTERNAL_UNIPHY
[    4.312064] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    4.465445] [drm] fb mappable at 0x80478000
[    4.469662] [drm] vram apper at 0x80000000
[    4.473775] [drm] size 8294400
[    4.476840] [drm] fb depth is 24
[    4.480084] [drm]    pitch is 7680
[    4.759376] Console: switching to colour frame buffer device 240x67
[    4.838736] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
[    4.845560] radeon 0001:81:00.0: registered panic notifier
[    4.856007] [drm] Initialized radeon 2.40.0 20080528 for 0001:81:00.0 on
minor 0

[   31.335598] [drm:dce6_audio_get_pin] *ERROR* No connected audio pins
found!



_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="http://lists.freedesktop.org/mailman/listinfo/dri-devel">http://lists.freedesktop.org/mailman/listinfo/dri-devel</a>

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------040504010708030005070900--
