Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C88CC679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Apr 2006 22:52:21 +1000 (EST)
Message-ID: <444CC568.3020500@ru.mvista.com>
Date: Mon, 24 Apr 2006 16:32:40 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Chang Sun <chang.sun@xilinx.com>
Subject: Re: question about Linux 2.6 with Xilinx ML-403
References: <0AF7A30943B8EF42B5A41B51B30BE52C0197306B@XSJ-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <0AF7A30943B8EF42B5A41B51B30BE52C0197306B@XSJ-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, "Martin, Tim" <tim.martin@viasat.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chang Sun wrote:
> Grant, 
> I checked both Torvalds' tree and Paul's tree. I see the defconfig file
> for both ml300 and ml403, but I don't see any source files related to
> either ml300 or ml403 under the <platforms> subdirectory. Have you done
> a complete BSP for either ml300 or ml403?
> 
> Thanks, 
> Chang

arch/ppc/platforms/4xx/virtex.c
arch/ppc/platforms/4xx/virtex.h
arch/ppc/platforms/4xx/xilinx_ml300.c
arch/ppc/platforms/4xx/xilinx_ml300.h
arch/ppc/platforms/4xx/xilinx_ml403.c
arch/ppc/platforms/4xx/xilinx_ml403.h

These are in the both trees you've mentioned.

Regards,
Andrei
