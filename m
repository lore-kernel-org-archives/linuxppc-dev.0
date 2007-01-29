Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 470CDDE030
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 01:31:52 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E85D9D7@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
	<A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6EF@zch01exm20.fsl.freescale.net>
	<F8DCDEDE-C060-458D-8E04-EA4C1EE2B2EE@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D9D7@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FC3C8B30-CD7C-4BE0-82AE-16E708B36374@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 29 Jan 2007 08:30:32 -0600
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2007, at 4:00 AM, Zhu Ebony-r57400 wrote:

> Hi Kumar,
>
> I think enabling SPEFSCR[FINXE] or SPEFSCR[FRMC]=0b10/0b11 to  
> enable FP
> round interrupt will cause the exception occurring very often, which
> will dramatically decrease the performance of SPE instructions. Do you
> think putting an option in menuconfig to let user choose whether to
> enable FP round simulation is a reasonable idea?

I don't see any issue with it, but I have to believe if you want full  
IEEE results, you want full IEEE results for everything.

- k
