Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CB2D66836C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 19:56:33 +1000 (EST)
Message-ID: <432FDCCF.30804@ru.mvista.com>
Date: Tue, 20 Sep 2005 13:56:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Landau, Bracha" <BLandau@nds.com>
References: <B621B955FA9FBB4C83F9724972F4DD1901CB5421@ILEX2.IL.NDS.COM>
In-Reply-To: <B621B955FA9FBB4C83F9724972F4DD1901CB5421@ILEX2.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: 8250 serial driver on MPC8272ADS board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Landau, Bracha wrote:
> I am running linux kernel 2.6.13 on a MPC8272ADS board. When I compile the kernel with the 8250 serial driver, the kernel crashes when loading it. It crashes also if compiled as a module and insmod'ed later.
> Has anyone had experience with this?

That's because this board does not have 8250 serial, you should use 
CPM_UART(SCC1 and SCC4) instead (take a look at the 
arch/ppc/configs/ads8272_defconfig)

-- 
Sincerely,
Vitaly
