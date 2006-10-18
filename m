Return-Path: <npbalajiirtt@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 833C767B75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 16:27:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so99369ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Oct 2006 23:27:56 -0700 (PDT)
Message-ID: <30d8ddcf0610172327w1fa87207n54b2f59402caaa14@mail.gmail.com>
Date: Wed, 18 Oct 2006 11:57:55 +0530
From: "Balaji N" <npbalajiirtt@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem in EHCI controller Driver and NEC D720100 chip set
In-Reply-To: <30d8ddcf0610172247u3d536fa3h96ee13cdafde92ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_165868_27384920.1161152875708"
References: <30d8ddcf0610172247u3d536fa3h96ee13cdafde92ef@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_165868_27384920.1161152875708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
   I am working on NEC D720100 chip set and I configured the EHCI, OHCI
controller drivers in the kernel 2.6.11. When the kernel boots,  it gave the
following error on the EHCI controller.

ehci_hcd 0000:00:11.2: Unlink after no-IRQ?  Controller is probably using
the wrong IRQ.
For OHCI controllers, it gave the following error.

ohci_hcd 0000:00:11.1: bogus NDP=255, rereads as NDP=255
ohci_hcd 0000:00:11.0: bogus NDP=255, rereads as NDP=255

I do not know that what is the problem. Please give ur suggestions to solve
this problem.

Thanks
  -N.Balaji

------=_Part_165868_27384920.1161152875708
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>
&nbsp;&nbsp; I am working on NEC D720100 chip set and I
configured the EHCI, OHCI controller drivers in the kernel 2.6.11. When the
kernel boots,&nbsp; it gave the following error on the EHCI controller.
<br>
<br>
ehci_hcd 0000:00:11.2: Unlink after no-IRQ?&nbsp; Controller is probably using the wrong IRQ. <br>
For OHCI controllers, it gave the following error. <br>
<br>
ohci_hcd 0000:00:11.1: bogus NDP=255, rereads as NDP=255<br>
ohci_hcd 0000:00:11.0: bogus NDP=255, rereads as NDP=255<br>
<br>
I do not know that what is the problem. Please give ur suggestions to solve this problem.<br>
<br>
Thanks <br><span class="sg">
&nbsp; -N.Balaji<br>
<br>
<br>

</span>

------=_Part_165868_27384920.1161152875708--
