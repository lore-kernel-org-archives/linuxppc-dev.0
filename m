Return-Path: <ravi.rao@rflelect.com>
In-Reply-To: <4ac2955e0803050644g2ccd2e46n305d2790389b517@mail.gmail.com>
To: "mahendra varman" <mahendravarman15@gmail.com>
Subject: Re: Unresolved symbols while inserting a module in linux
MIME-Version: 1.0
Message-ID: <OF9EDF1522.4B5A1F32-ON85257403.00522346-85257403.0052A659@slpower.com>
From: ravi.rao@rflelect.com
Date: Wed, 5 Mar 2008 10:01:44 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 0052A65485257403_="
Cc: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0052A65485257403_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
    In 2.6 kernel All the functions that are being used by a module should 
have been exported by the provider..
For Example If your driver module say foo.ko wants to use function x ( ) 
defined in bar.c, then in bar.c the function x () had be exported using
EXPORT_SYMBOL_GPL(x); If not when you try to insmod foo.ko U will get 
unresolved symbol x.
There should be something similar in 2.4..
 Thanks,
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 



"mahendra varman" <mahendravarman15@gmail.com> 
Sent by: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org
03/05/2008 09:44 AM

To
linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
cc

Subject
Unresolved symbols while inserting a module in linux






Hi all

For a customised hdlc card we have written hdlc driver.
we need to compile it as a module in linux 2.4.25 version
Thru Config.in we have defined the customised driver as tristate and
selected 'M' in menuconfig for that driver
The other dependencies generic hdlc driver, cisco , framedelay , ppp
etc are compiled as configured within the kernel itself
By giving make modules we have produced driver.o file

When I insert the driver.o using insmod iam getting the following
unresolved symbols
Even though the dependencies have been configured with the kernel
itself iam getting these unresolved symbols

If we use modprobe driver.o (or) modprobe driver it is reporting
driver:applet not found..

Help me to produce a module with its dependencies also to solve the
unresolved symbols error


Thanks

---------------------------------------------------- unresolved
symbols after insmod
------------------------------------------------------

Using driver.o
insmod: unresolved symbol pci_write_config_byte
insmod: unresolved symbol __netdev_watchdog_up
insmod: unresolved symbol schedule_timeout
insmod: unresolved symbol __kfree_skb
insmod: unresolved symbol alloc_skb
insmod: unresolved symbol pci_register_driver
insmod: unresolved symbol register_hdlc_device
insmod: unresolved symbol unregister_hdlc_device
insmod: unresolved symbol __release_region
insmod: unresolved symbol kmalloc
insmod: unresolved symbol pci_free_consistent
insmod: unresolved symbol pci_free_consistent
insmod: unresolved symbol __save_flags_ptr
insmod: unresolved symbol ioremap
insmod: unresolved symbol cpu_raise_softirq
insmod: unresolved symbol free_irq
insmod: unresolved symbol __out_of_line_bug
insmod: unresolved symbol iounmap
insmod: unresolved symbol pci_alloc_consistent
insmod: unresolved symbol iomem_resource
insmod: unresolved symbol kfree
insmod: unresolved symbol strlen
insmod: unresolved symbol request_irq
insmod: unresolved symbol netif_rx
insmod: unresolved symbol pci_unregister_driver
insmod: unresolved symbol skb_over_panic
insmod: unresolved symbol pci_set_master
insmod: unresolved symbol hdlc_ioctl
insmod: unresolved symbol jiffies
insmod: unresolved symbol __copy_tofrom_user
insmod: unresolved symbol __restore_flags
insmod: unresolved symbol softnet_data
insmod: unresolved symbol __request_region
insmod: unresolved symbol printk
insmod: unresolved symbol __cli
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--=_alternative 0052A65485257403_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; In 2.6 kernel All the
functions that are being used by a module should have been exported by
the provider..</font>
<br><font size=2 face="sans-serif">For Example If your driver module say
foo.ko wants to use function x ( ) &nbsp;defined in bar.c, then in bar.c
the function x () had be exported using</font>
<br><font size=2 face="sans-serif">EXPORT_SYMBOL_GPL(x); If not when you
try to insmod foo.ko U will get unresolved symbol x.</font>
<br><font size=2 face="sans-serif">There should be something similar in
2.4..</font>
<br><font size=2 face="sans-serif">&nbsp;Thanks,<br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>&quot;mahendra varman&quot;
&lt;mahendravarman15@gmail.com&gt;</b> </font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">03/05/2008 09:44 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Unresolved symbols while inserting a
module in linux</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>Hi all<br>
<br>
For a customised hdlc card we have written hdlc driver.<br>
we need to compile it as a module in linux 2.4.25 version<br>
Thru Config.in we have defined the customised driver as tristate and<br>
selected 'M' in menuconfig for that driver<br>
The other dependencies generic hdlc driver, cisco , framedelay , ppp<br>
etc are compiled as configured within the kernel itself<br>
By giving make modules we have produced driver.o file<br>
<br>
When I insert the driver.o using insmod iam getting the following<br>
unresolved symbols<br>
Even though the dependencies have been configured with the kernel<br>
itself iam getting these unresolved symbols<br>
<br>
If we use modprobe driver.o (or) modprobe driver it is reporting<br>
driver:applet not found..<br>
<br>
Help me to produce a module with its dependencies also to solve the<br>
unresolved symbols error<br>
<br>
<br>
Thanks<br>
<br>
---------------------------------------------------- unresolved<br>
symbols after insmod<br>
------------------------------------------------------<br>
<br>
Using driver.o<br>
insmod: unresolved symbol pci_write_config_byte<br>
insmod: unresolved symbol __netdev_watchdog_up<br>
insmod: unresolved symbol schedule_timeout<br>
insmod: unresolved symbol __kfree_skb<br>
insmod: unresolved symbol alloc_skb<br>
insmod: unresolved symbol pci_register_driver<br>
insmod: unresolved symbol register_hdlc_device<br>
insmod: unresolved symbol unregister_hdlc_device<br>
insmod: unresolved symbol __release_region<br>
insmod: unresolved symbol kmalloc<br>
insmod: unresolved symbol pci_free_consistent<br>
insmod: unresolved symbol pci_free_consistent<br>
insmod: unresolved symbol __save_flags_ptr<br>
insmod: unresolved symbol ioremap<br>
insmod: unresolved symbol cpu_raise_softirq<br>
insmod: unresolved symbol free_irq<br>
insmod: unresolved symbol __out_of_line_bug<br>
insmod: unresolved symbol iounmap<br>
insmod: unresolved symbol pci_alloc_consistent<br>
insmod: unresolved symbol iomem_resource<br>
insmod: unresolved symbol kfree<br>
insmod: unresolved symbol strlen<br>
insmod: unresolved symbol request_irq<br>
insmod: unresolved symbol netif_rx<br>
insmod: unresolved symbol pci_unregister_driver<br>
insmod: unresolved symbol skb_over_panic<br>
insmod: unresolved symbol pci_set_master<br>
insmod: unresolved symbol hdlc_ioctl<br>
insmod: unresolved symbol jiffies<br>
insmod: unresolved symbol __copy_tofrom_user<br>
insmod: unresolved symbol __restore_flags<br>
insmod: unresolved symbol softnet_data<br>
insmod: unresolved symbol __request_region<br>
insmod: unresolved symbol printk<br>
insmod: unresolved symbol __cli<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
</font></tt><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded"><tt><font size=2>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
</font></tt></a>
<br>
--=_alternative 0052A65485257403_=--
