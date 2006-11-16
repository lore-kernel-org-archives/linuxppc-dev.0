Return-Path: <maynardj@us.ibm.com>
Message-ID: <455CA088.3040807@us.ibm.com>
Date: Thu, 16 Nov 2006 11:31:52 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: [RFC, Patch 0/1] OProfile for Cell: Initial profiling support
	-- new	patch
References: <455B60E5.2040201@us.ibm.com>
In-Reply-To: <455B60E5.2040201@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on review comments received so far, we will be posting an updated 
kernel patch for OProfile for Cell.  Most notably, this patch removes 
some racey conditions between our "virtual counter" function and the 
interrupt handler, as well as fixing the way we were restarting and 
stopping our timer for the virtual counter.

Thanks.
-Maynard

Maynard Johnson wrote:

> Hello,
> I will be posting a patch that updates the OProfile kernel driver to 
> enable it for the Cell Broadband Engine processor.  The patch is based 
> on Arnd Bergmann's arnd6 patchset for 2.6.18  
> (http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.18-arnd6/), 
> with Kevin Corry's cbe_pmu_interrupt patch on applied on top.  Kevin 
> Corry's patch was submitted to the mailing lists earlier today and can 
> be found at:
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116360639928471&w=2).
> 
> I will also post an OProfile userpsace patch to the oprofile-list that 
> adds the necessary support for the Cell processor.
> 
> Thanks in advance for your review of this patch.
> 
> Maynard Johnson
> LTC Power Linux Toolchain
> 507-253-2650
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
