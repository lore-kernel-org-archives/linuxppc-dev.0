Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B513568811
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 00:04:07 +1100 (EST)
Message-ID: <438B0044.7070605@ru.mvista.com>
Date: Mon, 28 Nov 2005 16:04:04 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Landau, Bracha" <BLandau@nds.com>
References: <02AA386EB831044F8537A696BA785C7807645A@ILEX5.IL.NDS.COM>
In-Reply-To: <02AA386EB831044F8537A696BA785C7807645A@ILEX5.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: kernel 2.6.14 on MPC8272ADS
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
> I'm trying to move to the latest kernel release from linux 2.6.13.4 on the MPC8272ADS board.
> 2.6.13.4 works, but from 2.6.14 and up (I don't know where from 2.6.13.4 to 2.6.14 the problem starts) the kernel crashes on bootup with the message 
> "Kernel BUG in ppc_sys_init at arch/ppc/syslib/ppc_sys_init.c:131"
> Anyone know how to fix this problem?
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
The patch that 'fix' it is currently ready, I am about to submit it today, after I'll 
assure that nothing missed there.

-- 
Sincerely,
Vitaly
