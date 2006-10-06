Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id B6A6967E70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 12:16:43 +1000 (EST)
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id KAA23561
	for <linuxppc-embedded@ozlabs.org>; Fri, 6 Oct 2006 10:30:31 +0900 (JST)
MIME-Version: 1.0
Date: Fri, 06 Oct 2006 10:33:53 +0900
Subject: Re: Problem with initrd
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: Glenn.G.Hart@us.westinghouse.com, linuxppc-embedded@ozlabs.org
Message-ID: <JF2006100610335316.6823078@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <OF1D5D325D.8937E77C-ON852571FD.005C0832-852571FD.005CF8D2@ct.wec.com>
References: <OF1D5D325D.8937E77C-ON852571FD.005C0832-852571FD.005CF8D2@ct.wec.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Glenn-San,

Are you developing by the custom-made hardware of V4FX12?
If the 16-bit memory controller is used, it may have a problem in the
memory controller.

Can you try the memory controller of http://www.xilinx.com/mpmc2?
I confirmed that the 16-bit memory controller of MPMC2 worked correctly
by Linux. Or I can send the ramdisk image for 2.6.17.3 kernel which I
am using to you.

Yoshio kashiwagi - Nissin Systems
