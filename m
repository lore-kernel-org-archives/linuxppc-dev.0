Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEB62DDFB1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 19:34:25 +1000 (EST)
Message-ID: <46370991.3010802@cambridgebroadband.com>
Date: Tue, 01 May 2007 10:34:09 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: Anyone using mpc832x_mds & freescale's GIT repo?
References: <4636081D.2000507@cambridgebroadband.com>
	<20070430135200.23bb6bbf.kim.phillips@freescale.com>
In-Reply-To: <20070430135200.23bb6bbf.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
> On Mon, 30 Apr 2007 16:15:41 +0100
> Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
> 
>> Hi list,
>>
>> I've got an MPC8323E-MDS-PB development board, which is
>> running a year-old BSP from freescale.  I wanted to track
>> the most current developments so I cloned
>>
>> 	http://opensource.freescale.com/pub/scm/linux-2.6-83xx.git
>>
> that tree is obsolete; I'll label it so to avoid confusion.
> 
>> and rebuilt with ARCH=powerpc and using the mpc832x_mds_defconfig.
>>
>> I now don't get any serial console output after u-boot has
>> started the kernel.
>>
>> My questions are:
>>
>> 1.	Is anyone else using this GIT repo with this board?
>>
> please use the mpc83xx custodian tree on denx.de:
> 
> {git-,cg-}{clone,pull} git://www.denx.de/git/u-boot-mpc83xx.git
> 


Hi Kim,

Thanks for your reply.  I am already using the *u-boot* repo you
mention above.  Do you know which *linux* repository is the most
current for the MPC8323E-MDS-PB board?

Best regards,

Alex
