Return-Path: <chris@ilovelinux.de>
Received: from mail.sigmos.de (mail.sigmos.de [89.28.140.11])
	by bilbo.ozlabs.org (Postfix) with ESMTP id C48DCB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 05:57:41 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sigmos.de (Postfix) with ESMTP id 5A17813188A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 21:35:19 +0200 (CEST)
Received: from mail.sigmos.de ([127.0.0.1])
	by localhost (mail.sigmos.de [127.0.0.1]) (amavisd-maia, port 10024)
	with ESMTP id 22839-10 for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 21:35:18 +0200 (CEST)
Received: from chris.localnet (e183146156.adsl.alicedsl.de [85.183.146.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: chris@ilovelinux.de)
	by mail.sigmos.de (Postfix) with ESMTP id A3C6713188A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 21:35:18 +0200 (CEST)
From: Christian Schmitt <chris@ilovelinux.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: G4 radeon 9500 KMS issues
Date: Mon, 3 Aug 2009 21:35:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200908032135.14281.chris@ilovelinux.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm testing KMS on my G4 machine, but it is making problems. I tried different 
approaches:
When booting with KMS and agpmode=1 i get this output:

[drm] Initialized drm 1.1.0 20060810                                                           
[drm] radeon kernel modesetting enabled.                                                       
[drm:drm_init],                                                                                
[drm:drm_get_dev],                                                                             
radeon 0000:00:10.0: enabling device (0006 -> 0007)                                            
[drm:drm_get_minor],                                                                           
[drm:drm_get_minor], new minor assigned 64                                                     
[drm:drm_get_minor],                                                                           
[drm:drm_get_minor], new minor assigned 0                                                      
[drm] radeon: Initializing kernel modesetting.                                                 
[drm] register mmio base: 0x90000000                                                           
[drm] register mmio size: 65536                                                                
radeon 0000:00:10.0: Invalid ROM contents                                                      
radeon 0000:00:10.0: Invalid ROM contents                                                      
[drm:radeon_get_bios] *ERROR* Unable to locate a BIOS ROM                                      
[drm] GPU reset succeed (RBBM_STATUS=0x00000140)                                               
[drm] Using generic clock info                                                                 
[drm] Clocks initialized !                                                                     
[drm] Generation 2 PCI interface, using max accessible memory                                  
[drm] Detected VRAM RAM=32M, BAR=128M                                                          
[drm] RAM width 64bits DDR                                                                     
[drm] radeon: 1 pipes initialized.                                                             
agpgart-uninorth 0000:00:0b.0: putting AGP V2 device into 4x mode                              
radeon 0000:00:10.0: putting AGP V2 device into 4x mode                                        
[drm] radeon: VRAM 32M                                                                         
[drm] radeon: VRAM from 0x04000000 to 0x07FFFFFF                                               
[drm] radeon: VRAM less than aperture workaround enabled                                       
[drm] radeon: GTT 32M
[drm] radeon: GTT from 0x00000000 to 0x01FFFFFF
[drm:drm_irq_install], irq=48
[drm] radeon: irq initialized.
[TTM] TTM available graphics memory: 757 MiB
[TTM] TTM available object memory: 373 MiB
[drm] radeon: 32M of VRAM memory ready
[drm] radeon: 32M of GTT memory ready.
[drm] radeon: cp idle (0x10000C03)
[drm] Loading R300 Microcode
[drm] radeon: ring at 0x0000000000000000
[drm] ring test succeeded in 1 usecs
[drm] radeon: ib pool ready.
[drm:radeon_fence_wait] *ERROR* fence(efb3fea0:0x00000001) 510ms timeout going 
to reset GPU
[drm] CP reset succeed (RBBM_STATUS=0x00000140)
[drm] radeon: cp idle (0x10000000)
[drm] Loading R300 Microcode
[drm] radeon: ring at 0x0000000000000000
[drm:radeon_ring_test] *ERROR* radeon: ring test failed 
(sracth(0x15E8)=0xCAFEDEAD)
[drm:r100_cp_init] *ERROR* radeon: cp isn't working (-22).
[drm:r300_gpu_reset] *ERROR* Failed to reset GPU (RBBM_STATUS=0x80010140)
[drm:radeon_fence_wait] *ERROR* fence(efb3fea0:0x00000001) 666ms timeout
[drm:radeon_fence_wait] *ERROR* last signaled fence(0x00000001)
[drm:radeon_ib_test] *ERROR* radeon: ib test failed 
(sracth(0x15E4)=0xCAFEDEAD)
[drm:radeon_device_init] *ERROR* radeon: failled testing IB (-22).
[drm:radeon_driver_load_kms] *ERROR* Failed to initialize radeon, disabling 
IOCTL
[drm] radeon: finishing device.
[drm] radeon: cp finalized
[TTM] Used total memory is 0 bytes.
[drm] radeon: ttm finalized
[drm:drm_irq_uninstall], irq=48
[drm] radeon: fence finalized
[drm:drm_put_minor], release secondary minor 0
[drm:drm_put_minor], release secondary minor 64
radeon: probe of 0000:00:10.0 failed with error -22



When I try to disable AGP, the machine crashes badly. The problem is that I 
can hardly get any debug output, as the console is not working (see above) and 
I have to use a SSH session to get any access at all. Here is the log i get:

radeon agpmode=-1
 
Aug  3 13:17:08 [kernel] [drm] radeon kernel modesetting enabled.
Aug  3 13:17:08 [kernel] [drm:drm_init],
Aug  3 13:17:08 [kernel] [drm:drm_get_dev],
Aug  3 13:17:08 [kernel] [drm:drm_get_minor],
Aug  3 13:17:08 [kernel] [drm:drm_get_minor], new minor assigned 64
Aug  3 13:17:08 [kernel] [drm:drm_get_minor],
Aug  3 13:17:08 [kernel] [drm:drm_get_minor], new minor assigned 0
Aug  3 13:17:08 [kernel] [drm] radeon: Initializing kernel modesetting.
Aug  3 13:17:08 [kernel] [drm] Forcing AGP to PCI mode
Aug  3 13:17:08 [kernel] [drm] register mmio base: 0x90000000
Aug  3 13:17:08 [kernel] [drm] register mmio size: 65536
Aug  3 13:17:08 [kernel] radeon 0000:00:10.0: Invalid ROM contents
                - Last output repeated twice -
Aug  3 13:17:08 [kernel] [drm:radeon_get_bios] *ERROR* Unable to locate a BIOS 
ROM
Aug  3 13:17:08 [kernel] [drm] GPU reset succeed (RBBM_STATUS=0x00000140)
Aug  3 13:17:08 [kernel] [drm] Using generic clock info
Aug  3 13:17:08 [kernel] [drm] Clocks initialized !
Aug  3 13:17:08 [kernel] [drm] Generation 2 PCI interface, using max 
accessible memory
Aug  3 13:17:08 [kernel] [drm] Detected VRAM RAM=32M, BAR=128M
Aug  3 13:17:08 [kernel] [drm] RAM width 64bits DDR
Aug  3 13:17:08 [kernel] [drm] radeon: 1 pipes initialized.
Aug  3 13:17:08 [kernel] [drm] radeon: VRAM 32M
Aug  3 13:17:08 [kernel] [drm] radeon: VRAM from 0x00000000 to 0x03FFFFFF
Aug  3 13:17:08 [kernel] [drm] radeon: VRAM less than aperture workaround 
enabled
Aug  3 13:17:08 [kernel] [drm] radeon: GTT 512M
Aug  3 13:17:08 [kernel] [drm] radeon: GTT from 0x04000000 to 0x23FFFFFF
Aug  3 13:17:08 [kernel] [drm:drm_irq_install], irq=48
Aug  3 13:17:08 [kernel] [drm] radeon: irq initialized.
Aug  3 13:17:08 [kernel] [TTM] TTM available graphics memory: 757 MiB
Aug  3 13:17:08 [kernel] [TTM] TTM available object memory: 373 MiB
Aug  3 13:17:08 [kernel] [drm] radeon: 32M of VRAM memory ready
Aug  3 13:17:08 [kernel] [drm] radeon: 512M of GTT memory ready.
Aug  3 13:17:08 [kernel] [drm] GART: num cpu pages 131072, num gpu pages 
131072
Aug  3 13:17:08 [kernel] [drm] radeon: cp idle (0x10000000)
Aug  3 13:17:08 [kernel] [drm] Loading R300 Microcode
Aug  3 13:17:08 [kernel] [drm] radeon: ring at 0x0000000004000000
Aug  3 13:17:08 [kernel] [drm] ring test succeeded in 1 usecs
Aug  3 13:17:08 [kernel] [drm] radeon: ib pool ready.
Aug  3 13:17:08 [kernel] [drm] ib test succeeded in 0 usecs
Aug  3 13:17:08 [kernel] [drm] Connector Table: 2 (ibook)
Aug  3 13:17:08 [kernel] [drm] Panel info derived from registers
Aug  3 13:17:08 [kernel] [drm] Panel Size 1024x768
Aug  3 13:17:08 [kernel] [drm:drm_sysfs_connector_add], adding "LVDS-1" to 
sysfs
Aug  3 13:17:08 [kernel] [drm:drm_sysfs_hotplug_event], generating hotplug 
event
Aug  3 13:17:08 [kernel] [drm:drm_sysfs_connector_add], adding "VGA-1" to 
sysfs
Aug  3 13:17:08 [kernel] [drm:drm_sysfs_hotplug_event], generating hotplug 
event
Aug  3 13:17:08 [kernel] [drm] Radeon Display Connectors
Aug  3 13:17:08 [kernel] [drm] Connector 0:
Aug  3 13:17:08 [kernel] [drm]   LVDS
Aug  3 13:17:08 [kernel] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
Aug  3 13:17:08 [kernel] [drm]   Encoders:
Aug  3 13:17:08 [kernel] [drm]     LCD1: INTERNAL_LVDS
Aug  3 13:17:08 [kernel] [drm] Connector 1:
Aug  3 13:17:08 [kernel] [drm]   VGA
Aug  3 13:17:08 [kernel] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
Aug  3 13:17:08 [kernel] [drm]   Encoders:
Aug  3 13:17:08 [kernel] [drm]     CRT2: INTERNAL_DAC2


It is really difficult to get more debug output. Any help would be 
appreciated.

Cheers,
Chris
