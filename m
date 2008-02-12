Return-Path: <rakeshbk402@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id F41D1DDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 14:47:50 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so5042219pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 19:47:48 -0800 (PST)
Message-ID: <43455a600802111947r33ab1232u5f39fbdd986b7816@mail.gmail.com>
Date: Tue, 12 Feb 2008 09:17:48 +0530
From: "rakesh bk" <rakeshbk402@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Error while porting xenomai to power pc 750Cxe based SBC
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2400_9254476.1202788068311"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2400_9254476.1202788068311
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The results of your email command are provided below. Attached is your
original message.

- Results:
   Ignoring non-text/plain MIME parts

- Unprocessed:
   I am new to Xenomai , I have ported linux-2.6.14 to our custom board
based
   on IBM750Cxe Iam unable to boot my kernel cross compiled with eldk-3.0with
   enabled xenomai support.If i remove xenomai and ipipe support     the
kernel
   boots correctly , but if i enable i get the following oops message .
   The following patches are applied and arguements of scripts/prepare-
   kernel.sh is mentioned as follows
   adeos-ipipe-2.6.14-ppc-1.3-05.patch,
   Target architecture [default i686]: ppc
   Adeos patch[default linux-2.6.14/xenomai-2.2.0
   /ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:
   adeos-ipipe-2.6.14-ppc-1.3-05.patch,
   The following is the config file of the kernel which is sent as an
   attachement
   Oops: kernel access of bad area, sig: 11 [#1]
   PREEMPT
   NIP: 00000000 LR: A0044AA0 SP: A05B1CA0 REGS: a05b1bf0 TRAP: 0400    Not
   tainted
   MSR: 40001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
   TASK = a05af770[1] 'swapper' THREAD: a05b0000
   Last syscall: 120
   GPR00: 00000000 A05B1CA0 A05AF770 00000020 A0356400 00000001 A0382650

- Ignored:
   00000003
   GPR08: A0350000 00000000 A0317C00 00000001 2410C024 B3012797 07FE2800
   00000001
   GPR16: 00000000 00000001 EA100000 007FFF00 00000000 A0350000 A0350000
   A0350000
   GPR24: A0350000 A05B0000 A05B0000 A0382650 A079E480 00000020 A05B0000
   A0356400
   NIP [00000000] 0x0
   LR [a0044aa0] __do_IRQ+0x124/0x228
   Call trace:
    [a000f8e8] __ipipe_do_IRQ+0x20/0x34
    [a00469a8] __ipipe_sync_stage+0x204/0x208
    [a0046158] __ipipe_walk_pipeline+0xc8/0xd4
    [a000f6e4] __ipipe_handle_irq+0x94/0x1e4
    [a000f86c] __ipipe_grab_irq+0x38/0x94
    [a0005150] __ipipe_ret_from_except+0x0/0xc
    [00000020] 0x20
    [a01db8a8] mdio_read+0x24/0x38
    [a01db340] check_phy_state+0x34/0x19c
    [a01dc688] gt64260_eth_open+0x420/0x46c
    [a0227e14] dev_open+0xb8/0xd8
    [a0229d50] dev_change_flags+0x6c/0x158
    [a0379458] ic_open_devs+0x1e8/0x2fc
    [a037aa18] ip_auto_config+0x74/0x2e0
    [a035c738] do_initcalls+0x60/0xfc

------=_Part_2400_9254476.1202788068311
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The results of your email command are provided below. Attached is your<br>original message.<br><br>- Results:<br> &nbsp; &nbsp;Ignoring non-text/plain MIME parts<br><br>- Unprocessed:<br> &nbsp; &nbsp;I am new to Xenomai , I have ported linux-2.6.14 to our custom board based<br>


 &nbsp; &nbsp;on IBM750Cxe Iam unable to boot my kernel cross compiled with eldk-3.0 with<br> &nbsp; &nbsp;enabled xenomai support.If i remove xenomai and ipipe support &nbsp; &nbsp; the kernel<br> &nbsp; &nbsp;boots correctly , but if i enable i get the following oops message .<br>


 &nbsp; &nbsp;The following patches are applied and arguements of scripts/prepare-<br> &nbsp; &nbsp;kernel.sh is mentioned as follows<br> &nbsp; &nbsp;adeos-ipipe-2.6.14-ppc-1.3-05<div id="1fes" class="ArwC7c ckChnd">.patch,<br> &nbsp; &nbsp;Target architecture [default i686]: ppc<br>

 &nbsp; &nbsp;Adeos patch[default linux-2.6.14/xenomai-2.2.0<br> &nbsp; &nbsp;/ksrc/arch/powerpc/patches<div>/adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:<br> &nbsp; &nbsp;adeos-ipipe-2.6.14-ppc-1.3-05.patch,<br> &nbsp; &nbsp;The following is the config file of the kernel which is sent as an<br>


 &nbsp; &nbsp;attachement<br> &nbsp; &nbsp;Oops: kernel access of bad area, sig: 11 [#1]<br> &nbsp; &nbsp;PREEMPT<br> &nbsp; &nbsp;NIP: 00000000 LR: A0044AA0 SP: A05B1CA0 REGS: a05b1bf0 TRAP: 0400 &nbsp; &nbsp;Not<br> &nbsp; &nbsp;tainted<br> &nbsp; &nbsp;MSR: 40001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11<br>


 &nbsp; &nbsp;TASK = a05af770[1] &#39;swapper&#39; THREAD: a05b0000<br> &nbsp; &nbsp;Last syscall: 120<br> &nbsp; &nbsp;GPR00: 00000000 A05B1CA0 A05AF770 00000020 A0356400 00000001 A0382650<br><br>- Ignored:<br> &nbsp; &nbsp;00000003<br> &nbsp; &nbsp;GPR08: A0350000 00000000 A0317C00 00000001 2410C024 B3012797 07FE2800<br>


 &nbsp; &nbsp;00000001<br> &nbsp; &nbsp;GPR16: 00000000 00000001 EA100000 007FFF00 00000000 A0350000 A0350000<br> &nbsp; &nbsp;A0350000<br> &nbsp; &nbsp;GPR24: A0350000 A05B0000 A05B0000 A0382650 A079E480 00000020 A05B0000<br> &nbsp; &nbsp;A0356400<br> &nbsp; &nbsp;NIP [00000000] 0x0<br>


 &nbsp; &nbsp;LR [a0044aa0] __do_IRQ+0x124/0x228<br> &nbsp; &nbsp;Call trace:<br> &nbsp; &nbsp; [a000f8e8] __ipipe_do_IRQ+0x20/0x34<br> &nbsp; &nbsp; [a00469a8] __ipipe_sync_stage+0x204/0x208<br> &nbsp; &nbsp; [a0046158] __ipipe_walk_pipeline+0xc8/0xd4<br> &nbsp; &nbsp; [a000f6e4] __ipipe_handle_irq+0x94/0x1e4<br>


 &nbsp; &nbsp; [a000f86c] __ipipe_grab_irq+0x38/0x94<br> &nbsp; &nbsp; [a0005150] __ipipe_ret_from_except+0x0/0xc<br> &nbsp; &nbsp; [00000020] 0x20<br> &nbsp; &nbsp; [a01db8a8] mdio_read+0x24/0x38<br> &nbsp; &nbsp; [a01db340] check_phy_state+0x34/0x19c<br> &nbsp; &nbsp; [a01dc688] gt64260_eth_open+0x420/0x46c<br>


 &nbsp; &nbsp; [a0227e14] dev_open+0xb8/0xd8<br> &nbsp; &nbsp; [a0229d50] dev_change_flags+0x6c/0x158<br> &nbsp; &nbsp; [a0379458] ic_open_devs+0x1e8/0x2fc<br> &nbsp; &nbsp; [a037aa18] ip_auto_config+0x74/0x2e0<br> &nbsp; &nbsp; [a035c738] do_initcalls+0x60/0xfc</div></div>

------=_Part_2400_9254476.1202788068311--
