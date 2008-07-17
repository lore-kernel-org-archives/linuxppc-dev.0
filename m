Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 96ADADE200
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 17:15:33 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJNi5-0003JS-L2
	for linuxppc-embedded@ozlabs.org; Thu, 17 Jul 2008 00:15:29 -0700
Message-ID: <18502863.post@talk.nabble.com>
Date: Thu, 17 Jul 2008 00:15:29 -0700 (PDT)
From: Alex_SYS <schmid-grafenau@t-online.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Videomode 800x480
In-Reply-To: <18482586.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <18470632.post@talk.nabble.com> <487CEC85.2070801@denx.de>
	<18482586.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Alex_SYS wrote:
>=20
> <Here is the Kernel Bootup message that it gives when it crashes!
>=20
> U-Boot 1.2.0-mpc5200b-tiny-3 (Dec 11 2007 - 11:25:01)
>=20
> CPU:   MPC5200 v2.2, Core v1.4 at 399.999 MHz
>        Bus 133 MHz, IPB 133 MHz, PCI 33 MHz
> Board: phyCORE-MPC5200B-tiny
> I2C:   ready
> DRAM:  64 MB
> SP:    0x03f73768
> FLASH: 16 MB
> Using pcm030 machine description
> Linux version 2.6.23.1-rt5-pcm030-1trunk (aschmid@LINUX) (gcc version
> 4.1.2) #39
> 4 PREEMPT RT Tue Dec 11 17:58:48 CET 2007
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
> Built 1 zonelists in Zone order.  Total pages: 16256
> Kernel command line: video=3D0x0-16@60 , console=3DttyPSC0,115200
> mtdparts=3Dphysmap-f
> lash.0:256k(ubootl),1792k(kernel),13312k(jffs2),256k(uboot)ro,256k(oftree=
),-(spa
> ce) rw root=3D/dev/mtdblock2 rootfstype=3Djffs2
> WARNING: experimental RCU implementation.
> MPC52xx PIC is up and running!
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Console: colour dummy device 80x25
> console [ttyPSC0] enabled
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 61960k/65536k available (2624k kernel code, 3508k reserved, 144k
> data, 1
> 06k bss, 124k init)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> DMA: MPC52xx BestComm driver
> DMA: MPC52xx BestComm engine @f0001200 ok !
> Generic PHY: Registered new driver
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 2048 (order: 4, 73728 bytes)
> TCP bind hash table entries: 2048 (order: 3, 57344 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> JFFS2 version 2.2. (NAND) =C3=82=C2=A9 2001-2006 Red Hat, Inc.
> io scheduler noop registered (default)
> No Options from U-Boot
> Lime Driver PROBE
> No Mode
> Name des Strings 0x0-16@60 with L=C3=83=C2=A4nge 9
> Schleife mode Options
> Schleife @
> Schleife -
> Schleife x
> DONE vor CVT xres=3D 0 , yres=3D0 , cvt=3D
> 0******************************************
> ************CVT Mode: Trying specified video mode 0x0
> Trying mode 800x480-16@60 800x600-16@20
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x400-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x480-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 800x600-16@56
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1024x768-16@87
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x400-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x480-16@72
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x480-16@75
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 800x600-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x480-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x864-16@69
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 800x600-16@72
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1024x768-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 640x480-16@100
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x864-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 800x600-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1024x768-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@87
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 800x600-16@100
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1024x768-16@76
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x864-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@61
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1400x1050-16@68
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1400x1050-16@75
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1400x1050-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1024x768-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x864-16@78
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1600x1200-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x864-16@84
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@74
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1024x768-16@100
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@76
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1600x1200-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x864-16@100
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1600x1200-16@75
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1680x1050-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1600x1200-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1280x1024-16@100
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1800x1440-16@64
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1800x1440-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 512x384-16@78
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 512x384-16@85
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 320x200-16@70
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 320x240-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 320x240-16@72
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 400x300-16@56
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 400x300-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 400x300-16@72
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 480x300-16@56
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 480x300-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 480x300-16@63
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 480x300-16@72
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1920x1200-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1152x768-16@60
> Error=3D
> 0********************************************************************Tryi
> ng mode noname 1366x768-16@60
> Error=3D
> 0********************************************************************Tryi
> ng default video mode
> Trying mode noname 800x480-16@60
> Error=3D
> 0********************************************************************Tryi
> ng default mode
> Console: switching to colour frame buffer device 114x34
> stopped custom tracer.
> Oops: Exception in kernel mode, sig: 4 [#1]
> PREEMPT pcm030
> Modules linked in:
> NIP: 00000900 LR: c011d94c CTR: c011daf4
> REGS: c3fe7a30 TRAP: 0700   Not tainted  (2.6.23.1-rt5-pcm030-1trunk)
> MSR: 00081000 <ME>  CR: 42042022  XER: 00000000
> TASK =3D c3fe5c00[1] 'swapper' THREAD: c3fe6000
> GPR00: ffffffff c3fe7ae0 c3fe5c00 c5128bfc 00000000 00010001 00000020
> 00000020
> GPR08: 00000000 00010001 ffffffff 00000020 c3f5f800 fffffffb 03fcb000
> ffffffff
> GPR16: 00000001 00000000 c3fe7f78 c024a748 00000000 00000000 00000002
> 000001e0
> GPR24: 00010001 c011daf4 00000020 c3f5f800 c5128bfc 00000000 00000005
> 000001b0
> NIP [00000900] 0x900
> LR [c011d94c] cfb_fillrect+0x144/0x2ec
> Call Trace:
> [c3fe7ae0] [c00fd90c] number+0x354/0x374 (unreliable)
> [c3fe7b20] [c011c9c4] bit_clear_margins+0x100/0x104
> [c3fe7b60] [c0116254] fbcon_clear_margins+0x7c/0x80
> [c3fe7b70] [c011ba34] fbcon_switch+0x45c/0x630
> [c3fe7c40] [c01350cc] redraw_screen+0x158/0x200
> [c3fe7c60] [c0137878] bind_con_driver+0x2ec/0x428
> [c3fe7ca0] [c01379f4] take_over_console+0x40/0x58
> [c3fe7cc0] [c01199d0] fbcon_takeover+0x88/0xf8
> [c3fe7cd0] [c011a694] fbcon_event_notify+0x8e4/0x908
> [c3fe7da0] [c002e5a4] notifier_call_chain+0x60/0xb0
> [c3fe7dc0] [c002f2bc] __blocking_notifier_call_chain+0x50/0x74
> [c3fe7de0] [c011165c] fb_notifier_call_chain+0x24/0x34
> [c3fe7df0] [c0112600] register_framebuffer+0x120/0x1d0
> [c3fe7e50] [c0283380] vfb_probe+0x164/0x220
> [c3fe7e70] [c0142284] platform_drv_probe+0x20/0x30
> [c3fe7e80] [c01408e0] driver_probe_device+0xb8/0x1ec
> [c3fe7ea0] [c0140a98] __driver_attach+0x84/0x88
> [c3fe7ec0] [c013fbbc] bus_for_each_dev+0x58/0x94
> [c3fe7ef0] [c01406f0] driver_attach+0x24/0x34
> [c3fe7f00] [c0140018] bus_add_driver+0x98/0x1d8
> [c3fe7f20] [c0140c40] driver_register+0x58/0xa0
> [c3fe7f30] [c0142618] platform_driver_register+0x98/0xa8
> [c3fe7f40] [c0283534] vfb_init+0xf8/0x120
> [c3fe7f70] [c02711c4] kernel_init+0xa8/0x2bc
> [c3fe7ff0] [c000fd2c] kernel_thread+0x44/0x60
> Instruction dump:
> Unable to handle kernel paging request for data at address 0xffff83bc
> Faulting instruction address: 0xc00fd970
> Oops: Kernel access of bad area, sig: 11 [#2]
> PREEMPT pcm030
> Modules linked in:
> NIP: c00fd970 LR: c00fe29c CTR: 00000000
> REGS: c3fe7790 TRAP: 0300   Not tainted  (2.6.23.1-rt5-pcm030-1trunk)
> MSR: 00001032 <ME,IR,DR>  CR: 28044088  XER: 00000000
> DAR: ffff83bc, DSISR: 20000000
> TASK =3D c3fe5c00[1] 'swapper' THREAD: c3fe6000
> GPR00: c00fe29c c3fe7840 c3fe5c00 00000000 00000400 ffff83bc c3fe78f8
> 00004000
> GPR08: 00000000 00000002 ffff83bc c0296cc8 28042088 fffffffb 03fcb000
> ffffffff
> GPR16: 00000001 00000000 c3fe7f78 c024a748 00000000 00000000 c0290000
> c0290000
> GPR24: 00001032 c02bd934 c3fe78f8 c0250000 ffff83bc c02c0000 c02bdd34
> c02bd934
> NIP [c00fd970] vsnprintf+0x44/0x80c
> LR [c00fe29c] vscnprintf+0x18/0x1ac
> Call Trace:
> [c3fe7840] [c0045948] rt_down_trylock+0x20/0x70 (unreliable)
> [c3fe7870] [c00fe29c] vscnprintf+0x18/0x1ac
> [c3fe7880] [c001fb88] vprintk+0x94/0x3c4
> [c3fe78f0] [c001ff08] printk+0x50/0x60
> [c3fe7930] [c0008890] show_regs+0x2c4/0x2e8
> [c3fe7960] [c000d3bc] die+0xe8/0x198
> [c3fe7980] [c000d5e8] _exception+0x38/0x104
> [c3fe7a20] [c000f534] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at 0x900
>     LR =3D cfb_fillrect+0x144/0x2ec
> [c3fe7ae0] [c00fd90c] number+0x354/0x374 (unreliable)
> [c3fe7b20] [c011c9c4] bit_clear_margins+0x100/0x104
> [c3fe7b60] [c0116254] fbcon_clear_margins+0x7c/0x80
> [c3fe7b70] [c011ba34] fbcon_switch+0x45c/0x630
> [c3fe7c40] [c01350cc] redraw_screen+0x158/0x200
> [c3fe7c60] [c0137878] bind_con_driver+0x2ec/0x428
> [c3fe7ca0] [c01379f4] take_over_console+0x40/0x58
> [c3fe7cc0] [c01199d0] fbcon_takeover+0x88/0xf8
> [c3fe7cd0] [c011a694] fbcon_event_notify+0x8e4/0x908
> [c3fe7da0] [c002e5a4] notifier_call_chain+0x60/0xb0
> [c3fe7dc0] [c002f2bc] __blocking_notifier_call_chain+0x50/0x74
> [c3fe7de0] [c011165c] fb_notifier_call_chain+0x24/0x34
> [c3fe7df0] [c0112600] register_framebuffer+0x120/0x1d0
> [c3fe7e50] [c0283380] vfb_probe+0x164/0x220
> [c3fe7e70] [c0142284] platform_drv_probe+0x20/0x30
> [c3fe7e80] [c01408e0] driver_probe_device+0xb8/0x1ec
> [c3fe7ea0] [c0140a98] __driver_attach+0x84/0x88
> [c3fe7ec0] [c013fbbc] bus_for_each_dev+0x58/0x94
> [c3fe7ef0] [c01406f0] driver_attach+0x24/0x34
> [c3fe7f00] [c0140018] bus_add_driver+0x98/0x1d8
> [c3fe7f20] [c0140c40] driver_register+0x58/0xa0
> [c3fe7f30] [c0142618] platform_driver_register+0x98/0xa8
> [c3fe7f40] [c0283534] vfb_init+0xf8/0x120
> [c3fe7f70] [c02711c4] kernel_init+0xa8/0x2bc
> [c3fe7ff0] [c000fd2c] kernel_thread+0x44/0x60
> Instruction dump:
> 7c791b78 7cda3378 90010034 91810010 90a10008 419007bc 7fc32214 7f83f040
> 419d0260 81410008 7f3fcb78 38600000 <880a0000> 2f800000 419e0044 7f3fcb78
> Kernel panic - not syncing: Attempted to kill init!
> Call Trace:
> [c3fe7690] [c0007dfc] show_stack+0x3c/0x194 (unreliable)
> [c3fe76c0] [c001f004] panic+0x9c/0x174
> [c3fe7710] [c0023214] do_exit+0x6ec/0x884
> [c3fe7750] [c000d46c] kernel_bad_stack+0x0/0x4c
> [c3fe7770] [c00120ac] bad_page_fault+0x90/0xd8
> [c3fe7780] [c000f388] handle_page_fault+0x7c/0x80
> --- Exception: 300 at vsnprintf+0x44/0x80c
>     LR =3D vscnprintf+0x18/0x1ac
> [c3fe7840] [c0045948] rt_down_trylock+0x20/0x70 (unreliable)
> [c3fe7870] [c00fe29c] vscnprintf+0x18/0x1ac
> [c3fe7880] [c001fb88] vprintk+0x94/0x3c4
> [c3fe78f0] [c001ff08] printk+0x50/0x60
> [c3fe7930] [c0008890] show_regs+0x2c4/0x2e8
> [c3fe7960] [c000d3bc] die+0xe8/0x198
> [c3fe7980] [c000d5e8] _exception+0x38/0x104
> [c3fe7a20] [c000f534] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at 0x900
>     LR =3D cfb_fillrect+0x144/0x2ec
> [c3fe7ae0] [c00fd90c] number+0x354/0x374 (unreliable)
> [c3fe7b20] [c011c9c4] bit_clear_margins+0x100/0x104
> [c3fe7b60] [c0116254] fbcon_clear_margins+0x7c/0x80
> [c3fe7b70] [c011ba34] fbcon_switch+0x45c/0x630
> [c3fe7c40] [c01350cc] redraw_screen+0x158/0x200
> [c3fe7c60] [c0137878] bind_con_driver+0x2ec/0x428
> [c3fe7ca0] [c01379f4] take_over_console+0x40/0x58
> [c3fe7cc0] [c01199d0] fbcon_takeover+0x88/0xf8
> [c3fe7cd0] [c011a694] fbcon_event_notify+0x8e4/0x908
> [c3fe7da0] [c002e5a4] notifier_call_chain+0x60/0xb0
> [c3fe7dc0] [c002f2bc] __blocking_notifier_call_chain+0x50/0x74
> [c3fe7de0] [c011165c] fb_notifier_call_chain+0x24/0x34
> [c3fe7df0] [c0112600] register_framebuffer+0x120/0x1d0
> [c3fe7e50] [c0283380] vfb_probe+0x164/0x220
> [c3fe7e70] [c0142284] platform_drv_probe+0x20/0x30
> [c3fe7e80] [c01408e0] driver_probe_device+0xb8/0x1ec
> [c3fe7ea0] [c0140a98] __driver_attach+0x84/0x88
> [c3fe7ec0] [c013fbbc] bus_for_each_dev+0x58/0x94
> [c3fe7ef0] [c01406f0] driver_attach+0x24/0x34
> [c3fe7f00] [c0140018] bus_add_driver+0x98/0x1d8
> [c3fe7f20] [c0140c40] driver_register+0x58/0xa0
> [c3fe7f30] [c0142618] platform_driver_register+0x98/0xa8
> [c3fe7f40] [c0283534] vfb_init+0xf8/0x120
> [c3fe7f70] [c02711c4] kernel_init+0xa8/0x2bc
> [c3fe7ff0] [c000fd2c] kernel_thread+0x44/0x60
> Rebooting in 180 seconds..
> =20
> Hello,
>=20
> Alex_SYS wrote:
>> Hello, I have the problem that I need a Framebuffer resolution 800x480!
>> Since now I have filled the fb_info, var and fix Structs!
>> But there was the problem with the resolution!
>> I have found out that the problem is the videomode!
>> In modedb there is unfortunately no 800x480 Videomode, and I have tried
>> my
>> own 800x480 Struct, but the Kernel does`t want my settings (I tried to
>> change an 800x600 to 800x480 only by changing yres to 480).
>> Can someone tell me please a working fb_videomode struct for 800x480?
>=20
> Values for 800x480 fb_videomode depend on the TFT-panel that
> you are using. Without the spec of this panel it is hard to guess.
> It is also hard to guess the value for .pixclock as we do not know
> if internal or external clock is used as the source for display
> reference clock. What is the value of GDC DCM0 register (at
> offset 0x1fd0000 or 0x1fd0100 from the GDC base)?
>=20
> Try something like this:
> .xres =3D 800
> .yres =3D 480
> .pixclock =3D 40000
> .left_margin =3D 86
> .right_margin =3D 42
> .upper_margin =3D 33
> .lower_margin =3D 10
> .hsync_len =3D 128
> .vsync_len =3D 2
>=20
>> The syncs are setted up by U-Boot .
>=20
>>then you probably should retrieve proper values for fb_videomode
>>from display controller registers set up by U-Boot. If you do not
>>have the spec for your panel, it is the way to go. Consult the
>>GDC manual (Display control registers section) and
>>Documentation/fb/framebuffer.txt in the linux source tree.
>=20
> Hello, the physical settings for sync are made by U-Boot and working!
> But in Lunux when I use 800x480, the screen is well, but the Kernel
> crashes at Bootup!
> Using 800x600 works!
> Now I need only "Dummy" settings, that I can tell Linux I would like
> 800x480 and the Kernel doesn`t crash!
> I don`t know exactly why the Kernel crashes, I know only that the modedB
> 800x600 and so on work!
> I will try your settings immediately!
> Thanks
>=20
> Alex
>=20
> Best regards,
> Anatolij
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
>=20

--=20
View this message in context: http://www.nabble.com/Videomode-800x480-tp184=
70632p18502863.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
