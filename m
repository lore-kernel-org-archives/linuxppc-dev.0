Return-Path: <caner.altinbasak@gmail.com>
Message-ID: <2246c2320809170444j66aef147w638b44eb2f978410@mail.gmail.com>
Date: Wed, 17 Sep 2008 14:44:11 +0300
From: "Caner Altinbasak" <caner.altinbasak@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: spinlock problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8089_15094899.1221651851659"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8089_15094899.1221651851659
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!
I am using a Curtiss Wright DY4-183 board with PPC7447 CPU. I've a pci
graphics card with a M9 GPU on it. There is a transparent bridge between the
GPU and my PCI bus. My problem a trouble with radeon_dri driver. I want to
run a miniglx application to see how the graphics performance is but I am
having the following error. I think there is a problem with unhandled
interrupts! Have an idea?

-bash-3.2# ./sample_server &
[1] 1082
-bash-3.2# [miniglx] probed chipset 0x4c66
got MMIOAddress 0x1801e000 offset 67108864
shared virtual width is 1024
[drm] added 8192 byte SAREA at 0x61036000
[drm] mapped SAREA 0x61036000 to 0x18026000, size 8192
[drm] framebuffer handle = 0x80000000
[drm] register handle = 0x70000000
[pci] 8192 kB allocated with handle 0x62187000
[pci] ring handle = 0x62187000
[pci] ring read ptr handle = 0x62288000
[pci] vertex/indirect buffers handle = 0x62289000
[pci] GART texture map handle = 0x62489000
Using 8 MB AGP aperture
Using 1 MB for the ring buffhStart = 1040, hEnd = 1136, hTotal = 1312
vStart = 769, vEnd = 772, vTotal = 800
h_total_disp = 0x7f00a3    hsync_strt_wid = 0x8c040d
v_total_disp = 0x2ff031f           vsync_strt_wid = 0x830300
pixclock = 12699
freq = 7874
freq = 7874, PLL min = 12000, PLL max = 35000
ref_div = 5, ref_clk = 2700, output_freq = 15748
ref_div = 5, ref_clk = 2700, output_freq = 15748
post div = 0x1
fb_div = 0x1d
ppll_div_3 = 0x1001d
er
Using 2 MB for BUG: soft lockup detected on CPU#0!
NIP: 40042044 LR: 40042140 CTR: 400185B4
REGS: 5e25bbb0 TRAP: 0901   Not tainted  (2.6.16.13.CWCEC.K)
MSR: 00009032 <EE,ME,IR,DR>  CR: 2490C142  XER: 20000000
TASK = 40aa78b0[1082] 'sample_server' THREAD: 5e25a000
NIP [40042044] handle_IRQ_event+0x34/0xb8
LR [40042140] __do_IRQ+0x78/0x1a0
Call Trace:
[5E25BC60] [400188A8] cw_pic_unmask_irq_183+0x118/0x138 (unreliable)
[5E25BC80] [40042140] __do_IRQ+0x78/0x1a0
[5E25BCB0] [4000B1E4] do_IRQ+0x44/0x88
[5E25BCD0] [40004F1C] ret_from_except+0x0/0x14
[5E25BD90] [40049DDC] __alloc_pages+0x70/0x2a4
[5E25BDA0] [40042074] handle_IRQ_event+0x64/0xb8
[5E25BDC0] [40042140] __do_IRQ+0x78/0x1a0
[5E25BDF0] [4000B1E4] do_IRQ+0x44/0x88
[5E25BE10] [40004F1C] ret_from_except+0x0/0x14
[5E25BED0] [400244CC] __do_softirq+0x50/0x120
[5E25BF00] [40024614] do_softirq+0x78/0x80
[5E25BF10] [4002478C] irq_exit+0x60/0x78
[5E25BF20] [4000B1E8] do_IRQ+0x48/0x88
[5E25BF40] [40004F1C] ret_from_except+0x0/0x14
Instruction dump:
9421ffe0 bf61000c 7cbf2b78 7c7b1b78 7c9d2378 90010024 80050004 74092000
40820010 7c0000a6 60008000 7c000124 <3bc00000> 3b800000 48000010 83ff0014
vertex/indirect buffers
Using 1 MB for AGP textures
Will use back buffer at offset 0x300000
Will use depth buffer at offset 0x600000
Will use 56320 kb for textures at offset 0x900000
[drm] Added 32 65536 byte vertex/indirect buffers
[drm] dma control initialized, using IRQ 16
[drm] Initialized kernel gart heap manager, 5111808
color tiling disabled
page flipping disabled
[miniglx] Setting mode: visible 1024x768 virtual 1024x768x32
[miniglx] Readback mode: visible 1024x768 virtual 1024x768x32
RADEONEngineRestore

------=_Part_8089_15094899.1221651851659
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi!<br>I am using a Curtiss Wright DY4-183 board with PPC7447 CPU. I&#39;ve a pci graphics card with a M9 GPU on it. There is a transparent bridge between the GPU and my PCI bus. My problem a trouble with radeon_dri driver. I want to run a miniglx application to see how the graphics performance is but I am having the following error. I think there is a problem with unhandled interrupts! Have an idea?<br>
<br>-bash-3.2# ./sample_server &amp;<br>[1] 1082<br>-bash-3.2# [miniglx] probed chipset 0x4c66<br>got MMIOAddress 0x1801e000 offset 67108864<br>shared virtual width is 1024<br>[drm] added 8192 byte SAREA at 0x61036000<br>
[drm] mapped SAREA 0x61036000 to 0x18026000, size 8192<br>[drm] framebuffer handle = 0x80000000<br>[drm] register handle = 0x70000000<br>[pci] 8192 kB allocated with handle 0x62187000<br>[pci] ring handle = 0x62187000<br>
[pci] ring read ptr handle = 0x62288000<br>[pci] vertex/indirect buffers handle = 0x62289000<br>[pci] GART texture map handle = 0x62489000<br>Using 8 MB AGP aperture<br>Using 1 MB for the ring buffhStart = 1040, hEnd = 1136, hTotal = 1312<br>
vStart = 769, vEnd = 772, vTotal = 800<br>h_total_disp = 0x7f00a3&nbsp;&nbsp;&nbsp; hsync_strt_wid = 0x8c040d<br>v_total_disp = 0x2ff031f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vsync_strt_wid = 0x830300<br>pixclock = 12699<br>freq = 7874<br>freq = 7874, PLL min = 12000, PLL max = 35000<br>
ref_div = 5, ref_clk = 2700, output_freq = 15748<br>ref_div = 5, ref_clk = 2700, output_freq = 15748<br>post div = 0x1<br>fb_div = 0x1d<br>ppll_div_3 = 0x1001d<br>er<br>Using 2 MB for BUG: soft lockup detected on CPU#0!<br>
NIP: 40042044 LR: 40042140 CTR: 400185B4<br>REGS: 5e25bbb0 TRAP: 0901&nbsp;&nbsp; Not tainted&nbsp; (2.6.16.13.CWCEC.K)<br>MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 2490C142&nbsp; XER: 20000000<br>TASK = 40aa78b0[1082] &#39;sample_server&#39; THREAD: 5e25a000<br>
NIP [40042044] handle_IRQ_event+0x34/0xb8<br>LR [40042140] __do_IRQ+0x78/0x1a0<br>Call Trace:<br>[5E25BC60] [400188A8] cw_pic_unmask_irq_183+0x118/0x138 (unreliable)<br>[5E25BC80] [40042140] __do_IRQ+0x78/0x1a0<br>[5E25BCB0] [4000B1E4] do_IRQ+0x44/0x88<br>
[5E25BCD0] [40004F1C] ret_from_except+0x0/0x14<br>[5E25BD90] [40049DDC] __alloc_pages+0x70/0x2a4<br>[5E25BDA0] [40042074] handle_IRQ_event+0x64/0xb8<br>[5E25BDC0] [40042140] __do_IRQ+0x78/0x1a0<br>[5E25BDF0] [4000B1E4] do_IRQ+0x44/0x88<br>
[5E25BE10] [40004F1C] ret_from_except+0x0/0x14<br>[5E25BED0] [400244CC] __do_softirq+0x50/0x120<br>[5E25BF00] [40024614] do_softirq+0x78/0x80<br>[5E25BF10] [4002478C] irq_exit+0x60/0x78<br>[5E25BF20] [4000B1E8] do_IRQ+0x48/0x88<br>
[5E25BF40] [40004F1C] ret_from_except+0x0/0x14<br>Instruction dump:<br>9421ffe0 bf61000c 7cbf2b78 7c7b1b78 7c9d2378 90010024 80050004 74092000 <br>40820010 7c0000a6 60008000 7c000124 &lt;3bc00000&gt; 3b800000 48000010 83ff0014 <br>
vertex/indirect buffers<br>Using 1 MB for AGP textures<br>Will use back buffer at offset 0x300000<br>Will use depth buffer at offset 0x600000<br>Will use 56320 kb for textures at offset 0x900000<br>[drm] Added 32 65536 byte vertex/indirect buffers<br>
[drm] dma control initialized, using IRQ 16<br>[drm] Initialized kernel gart heap manager, 5111808<br>color tiling disabled<br>page flipping disabled<br>[miniglx] Setting mode: visible 1024x768 virtual 1024x768x32<br>[miniglx] Readback mode: visible 1024x768 virtual 1024x768x32<br>
RADEONEngineRestore<br><br><br><br></div>

------=_Part_8089_15094899.1221651851659--
