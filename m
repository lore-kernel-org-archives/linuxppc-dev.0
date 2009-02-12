Return-Path: <bg.anil@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id CF0CCDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 16:09:04 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so508986wfd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 21:09:03 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 10:39:03 +0530
Message-ID: <8b0974ca0902112109m145812d8ibabf56a8face1cb7@mail.gmail.com>
Subject: WARNING Cannot determine dependencies of kernel module 'uhci-hcd'.?
From: Anil B G <bg.anil@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd331dc0c971e0462b1b809
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd331dc0c971e0462b1b809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

1. I was trying to build the linux 2.6.28.4 kernel on a ppc system

While building there was an issue in the mkinitrd as below

-------------------------------------------------------------------------------------------------------------------

 Kernel image: /boot/vmlinux-2.6.27.5-2-ppc64

Initrd image: /boot/abc

Root device: /dev/disk/by-id/scsi-35000cca005281f3c-part3 (/dev/sda3)
(mounted on / as ext3)

WARNING Cannot determine dependencies of kernel module 'uhci-hcd'.

Does it exist? If it does, try depmod -a. Continuing without uhci-hcd.

Features: block usb resume.userspace resume.kernel

depmod -a works fine.
-------------------------------------------------------------------------------------------------------------------

I tried enabling OHCI inplace of UHCI in the .config and got similar
results. I then tried disabling USB in the menuconfig, but still got the
same result.

I then tried with a different kernel (2.6.27.5) and got pretty much the same
result.

Any suggestions on how to get around this problem?

Regards,

Anil

--000e0cd331dc0c971e0462b1b809
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,<br>&nbsp; <br><div><span class="721454104-12022009"><font face="Arial" size="2">1. I 
was trying to build the linux 2.6.28.4 kernel on a ppc system<br><br>While 
building there was an issue in the mkinitrd as below<br><br></font></span><span class="721454104-12022009">-------------------------------------------------------------------------------------------------------------------</span><br>
</div>
<div><span class="721454104-12022009"></span> <br>&nbsp;<font size="2">Kernel image: /boot/vmlinux-2.6.27.5-2-ppc64</font></div>
<div><span class="721454104-12022009">
<p><font size="2">Initrd image: /boot/abc</font></p>
<p><font size="2">Root device: /dev/disk/by-id/scsi-35000cca005281f3c-part3 
(/dev/sda3) (mounted on / as ext3)</font></p>
<p><font size="2">WARNING Cannot determine dependencies of kernel module 
&#39;uhci-hcd&#39;.</font></p>
<p><font size="2">Does it exist? If it does, try depmod -a. Continuing without 
uhci-hcd.</font></p>
<p><font size="2">Features: block usb resume.userspace resume.kernel</font></p><p><span class="721454104-12022009"><font face="Arial" size="2">depmod -a works 
fine.</font></span></p>-------------------------------------------------------------------------------------------------------------------<br>
<p><span class="721454104-12022009"><font face="Arial" size="2">I tried enabling OHCI 
inplace of UHCI in the .config and got similar results. I then tried disabling 
USB in the menuconfig, but still got the same result.</font></span></p>
<p><span class="721454104-12022009"><font face="Arial" size="2">I then tried with a 
different kernel (2.6.27.5) and got pretty much the same 
result.</font></span></p>
<p><span class="721454104-12022009"><font face="Arial" size="2">Any suggestions on how 
to get around this problem?</font></span></p><p><span class="721454104-12022009"><font face="Arial" size="2">Regards,</font></span></p><p><span class="721454104-12022009"><font face="Arial" size="2">Anil<br></font></span></p>
</span></div>

--000e0cd331dc0c971e0462b1b809--
