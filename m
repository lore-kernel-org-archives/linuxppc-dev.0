Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.2.87]) by ozlabs.org (Postfix) with ESMTP id 08F9C67A7B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 18:13:03 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2M7CwwY012737
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 08:12:58 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <423FC578.8040202@246tNt.com>
Date: Tue, 22 Mar 2005 08:12:56 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
	<556f5ce38ca914dce63ca24277af4b3e@freescale.com>
In-Reply-To: <556f5ce38ca914dce63ca24277af4b3e@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 0/6] [RFC] Change MPC52xx to platform bus / ppc_sys model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Kumar Gala wrote:
> Took a quick glance at the patches and they look good.  Do you have a bk 
> tree available with all these changes in them?
> 
> I think a might have a few minor comments, but might be easier to see 
> the bk tree.

Sure, bk://tnt.bkbits.net/linux-2.5-mpc52xx-pending


The only difference between that tree and the patch is a few trailing
white space that are in BK but not in the patch.

Note that now, I should also add CONFIG_PPC_MPC52xx to the change of
/proc/cpuinfo. What about a CONFIG_PPC_SYS that would include ppc_sys.o
in the kernel and activate the /proc/cpuinfo chipset line ?



	Sylvain
