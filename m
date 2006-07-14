Return-Path: <urwithsudheer@gmail.com>
Received: from predator.gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id CD82E679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 20:39:04 +1000 (EST)
Received: from predator.gdatech.co.in (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id C07A71242DB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 16:08:23 +0530 (IST)
Received: from predator.gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Propel SE relay 1.0.0.3430
	$Rev$) id r67e160823-00-2
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jul 2006 16:08:23 +0530
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D8EE01242DA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 16:08:22 +0530 (IST)
Message-ID: <44B77438.3070607@gmail.com>
Date: Fri, 14 Jul 2006 16:08:48 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [Fwd: Re: [Ilugc] help regarding powerpc and vga card]
Content-Type: multipart/mixed; boundary="------------020804080504090407060104"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020804080504090407060104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020804080504090407060104
Content-Type: message/rfc822;
 name="Re: [Ilugc] help regarding powerpc and vga card"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Ilugc] help regarding powerpc and vga card"

X-Gmail-Received: 798101e1139b1d72a079c9533b1f559cbed86aa6
Delivered-To: urwithsudheer@gmail.com
Received: by 10.67.23.4 with SMTP id a4cs53971ugj;
        Thu, 13 Jul 2006 07:28:57 -0700 (PDT)
Received: by 10.78.116.19 with SMTP id o19mr550117huc;
        Thu, 13 Jul 2006 07:28:57 -0700 (PDT)
Received: by 10.78.15.17 with HTTP; Thu, 13 Jul 2006 07:28:57 -0700 (PDT)
Message-ID: <a8f990120607130728l1c16e3d2k6b1a09a02c1ed0f3@mail.gmail.com>
Date: Thu, 13 Jul 2006 10:28:57 -0400
From: "Sivasankar Chander" <siva.ilugc@gmail.com>
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: [Ilugc] help regarding powerpc and vga card
Cc: ilugc@ae.iitm.ac.in
In-Reply-To: <44B6077E.9090004@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12165_14066581.1152800937196"
References: <44B6077E.9090004@gmail.com>

------=_Part_12165_14066581.1152800937196
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/13/06, sudheer <urwithsudheer@gmail.com> wrote:
>
>
>
> Anyone please help me if i am missing anything.
>
>     All PCI VGA cards for use on x86 PCs have a ROMscan BIOS
extension on them. This initializes the card after POST - basically,
the motherboard BIOS transfers control to the BIOS on the
PCI VGA card, which then initializes itself. If control is not
transfered to the VGA BIOS on the card, the VGA controller
stays isolated and will not respond to PCI device enumeration,
etc. This is actually part of the PC-98 spec., which allows
multiple VGA controllers to co-exist on the PCI and/or AGP
bus.

   On a PowerPC system, the ROMscan BIOS cannot execute
(because it has x86 instructions in it), so there will be an alternate
way to initialize the VGA controller so that it can respond to the
PCI enumeration, etc. However, that method will be card/controller
specific - neither the card manufacturer nor ATI may ever have
released the specs for how this is done. Usually, it will be through
hidden memory-mapped IO (MMIO) registers on the VGA controller
chip, but there are numerous proprietary ways to implement this,
most of it being undocumented or controller-specific.

(Lots of things are taken for granted in the x86 PC world, which
are actually very complex and difficult-to-implement protocols.
That's one of the reasons why all the alternative PC processor
architectures have failed over the last 20 years).

-Siva

------=_Part_12165_14066581.1152800937196
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 7/13/06, <b class="gmail_sendername">sudheer</b> &lt;<a href="mailto:urwithsudheer@gmail.com">urwithsudheer@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br>Anyone please help me if i am missing anything.<br><br></blockquote></div>&nbsp;&nbsp;&nbsp; All PCI VGA cards for use on x86 PCs have a ROMscan BIOS<br>
extension on them. This initializes the card after POST - basically,<br>
the motherboard BIOS transfers control to the BIOS on the<br>
PCI VGA card, which then initializes itself. If control is not<br>
transfered to the VGA BIOS on the card, the VGA controller<br>
stays isolated and will not respond to PCI device enumeration,<br>
etc. This is actually part of the PC-98 spec., which allows<br>
multiple VGA controllers to co-exist on the PCI and/or AGP<br>
bus.<br>
<br>
&nbsp;&nbsp; On a PowerPC system, the ROMscan BIOS cannot execute<br>
(because it has x86 instructions in it), so there will be an alternate<br>
way to initialize the VGA controller so that it can respond to the<br>
PCI enumeration, etc. However, that method will be card/controller<br>
specific - neither the card manufacturer nor ATI may ever have<br>
released the specs for how this is done. Usually, it will be through<br>
hidden memory-mapped IO (MMIO) registers on the VGA controller<br>
chip, but there are numerous proprietary ways to implement this,<br>
most of it being undocumented or controller-specific.<br>
<br>
(Lots of things are taken for granted in the x86 PC world, which<br>
are actually very complex and difficult-to-implement protocols.<br>
That's one of the reasons why all the alternative PC processor<br>
architectures have failed over the last 20 years).<br>
<br>
-Siva<br>

------=_Part_12165_14066581.1152800937196--


--------------020804080504090407060104--
