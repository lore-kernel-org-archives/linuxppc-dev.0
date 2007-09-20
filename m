Return-Path: <ioecas@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id DCEDEDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 15:51:57 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so393859nfd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 22:51:56 -0700 (PDT)
Message-ID: <5a65c5e70709192251hb238dc3j498c39ac15ac7871@mail.gmail.com>
Date: Thu, 20 Sep 2007 13:51:55 +0800
From: "yuan tian" <ioecas@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: a problem of scsi(lsi 53c1020) driver
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24473_14244303.1190267515922"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_24473_14244303.1190267515922
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi:
  Now there is a scsi controller(LSI 53c1020) on the pci slot of
ocotea(ppc440gx).
  I don't know if there is a driver of LSI53c1020 in Linux kernel(2.6.21).

 In kernel configuration ,my options are:
 Device Drivers  --->
         Fusion MPT device support  --->
          <*> Fusion MPT ScsiHost drivers for SPI

 Device Drivers  --->
         SCSI device support  --->
        <*> SCSI device support
        <*> SCSI disk support
 When the kernel was executed, some error information come from the console.

 copyright (c) 1999-2007 LSI Logic Corporation
 Fusion MPT SPI Host driver 3.04.04
 mptbase: Initiating ioc0 bringup
 ioc0: 53C1030: Capabilities={Initiator}
 scsi0 : ioc0: LSI53C1030, FwRev=01000300h, Ports=1, MaxQ=255, IRQ=25
 mptbase: ioc0: LogInfo(0x11010100): F/W: bug! MID not found
 mptbase: ioc0: LogInfo(0x11010100): F/W: bug! MID not found

 I don't know if there is something wrong in my kernel configuration .
 Any help will be appreciated!

 Regards,
 Tom

------=_Part_24473_14244303.1190267515922
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>hi:&nbsp;<br>&nbsp; Now there is a scsi controller(LSI 53c1020) on the pci slot of ocotea(ppc440gx).<br>&nbsp;&nbsp;I don&#39;t know if there is a driver of LSI53c1020 in Linux kernel(2.6.21).<br>&nbsp;<br>&nbsp;In kernel configuration ,my options are:
<br>&nbsp;Device Drivers&nbsp; ---&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Fusion MPT device support&nbsp; ---&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&lt;*&gt; Fusion MPT ScsiHost drivers for SPI<br>&nbsp;<br>&nbsp;Device Drivers&nbsp; ---&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;SCSI device support&nbsp; ---&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&lt;*&gt; SCSI device support
<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&lt;*&gt; SCSI disk support<br>&nbsp;When the kernel was executed, some error information come from the console.</p>
<p>&nbsp;copyright (c) 1999-2007 LSI Logic Corporation<br>&nbsp;Fusion MPT SPI Host driver 3.04.04<br>&nbsp;mptbase: Initiating ioc0 bringup<br>&nbsp;ioc0: 53C1030: Capabilities={Initiator}<br>&nbsp;scsi0 : ioc0: LSI53C1030, FwRev=01000300h, Ports=1, MaxQ=255, IRQ=25
<br>&nbsp;mptbase: ioc0: LogInfo(0x11010100): F/W: bug! MID not found<br>&nbsp;mptbase: ioc0: LogInfo(0x11010100): F/W: bug! MID not found<br>&nbsp;<br>&nbsp;I don&#39;t know if there is something wrong in my kernel configuration .<br>&nbsp;Any help will be appreciated!
</p>
<p>&nbsp;Regards,<br>&nbsp;Tom</p>

------=_Part_24473_14244303.1190267515922--
