Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41B59DDFA3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 00:05:57 +1000 (EST)
Message-ID: <46374938.6090707@cambridgebroadband.com>
Date: Tue, 01 May 2007 15:05:44 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: Anyone using mpc832x_mds & freescale's GIT repo?
References: <4636081D.2000507@cambridgebroadband.com>	<20070430135200.23bb6bbf.kim.phillips@freescale.com>	<46370991.3010802@cambridgebroadband.com>
	<20070501090006.4c9f5723.kim.phillips@freescale.com>
In-Reply-To: <20070501090006.4c9f5723.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kim Phillips wrote:
> On Tue, 01 May 2007 10:34:09 +0100
> Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
> 
>> mention above.  Do you know which *linux* repository is the most
>> current for the MPC8323E-MDS-PB board?
> 
> yes, linux..normally I'd say paulus' powerpc.git tree on kernel.org, but
> today, 832x-MDS is broken there.  You might want to checkout the v2.6.21
> tag until the pending patches (to support the ucc phylib) are applied and
> merged.
> 

Thanks again for your reply.  I know this is going to sound like I'm repeating
myself, but I want to be sure....

Would you recommend using powerpc.git v2.6.21 in preference to the 2.6.11
kernel that comes with the latest Freescale BSP (MPC832xE_MDS_K26_20070130-LTIB.iso)?

TIA,

Alex
