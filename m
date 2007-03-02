Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 8DECBDDED3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 18:31:17 +1100 (EST)
Date: Fri, 2 Mar 2007 08:31:09 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: New Bestcomm/FEC patches (was: Re: [PATCH 0/7] MPC5200 and
	Lite5200b low power modes)
Message-ID: <20070302073109.GS4397@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
	<528646bc0703010625o92ff794ra5ba561b0861f2e3@mail.gmail.com>
	<45E6E888.9050508@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E6E888.9050508@semihalf.com>
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

On 01/03/07 15:51 +0100, Bartlomiej Sieka wrote:
> Grant Likely wrote:
> > On 3/1/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> >> Hi!
> >>
> >> Patches are based on latest mainline git tree + fec patches:
> >> Fec_MPC5200_eth_driver.patch
> >> Copy_bestcomm_support_files_into_arch_powerpc.patch
> >> Make_FEC_work_on_the_lite5200.patch
> >>
> > ---8<---snip--->8---
> >> I would appreaciate any comments, suggestions etc.
> > 
> > Cool, good work.  I'll try to do a proper review today.
> > 
> > Note on the Bestcomm stuff; the patches that you've referenced above
> > will not be going into mainline.  They will be replaced by a new set
> > of bestcomm/FEC patches, hopfully in the .22 timeframe, so your
> > patches there will need some rework.
> 
> Hello,
> 
> I am working on porting arch/powerpc Linux to a custom MPC5200B-based 
> board, and currently using your 52xx-dev branch. Is this new set of 
> bestcomm/FEC patches already in any of your publicly available branches, 
> or is it something completely fresh? I am seeing some networking 
> problems, and would be interested in giving new patches a try.

Patches I used were from Grant's 52xx-dev branch.


	Domen

> 
> Regards,
> Bartlomiej
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
