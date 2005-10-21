Return-Path: <sharada@in.ibm.com>
Received: from pokfb.esmtp.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D3E16863A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 21:03:16 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.boulder.ibm.com [9.17.249.45])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j9LB3CRt003354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 07:03:13 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9LB38vs003691
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 07:03:08 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id
	j9LB43tE536178
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 05:04:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j9LB37dR017514
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 05:03:08 -0600
Date: Fri, 21 Oct 2005 16:32:08 +0530
From: R Sharada <sharada@in.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Message-ID: <20051021110208.GA3612@in.ibm.com>
References: <435876B8.9000706@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <435876B8.9000706@nortel.com>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status of kexec for ppc on 2.6.10, any gotchas?
Reply-To: sharada@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


	Kexec support involves kernel level support per architecture and 
a user space kexec-tools.

	Generic kexec kernel support for ppc (ppc32/GameCube) was added 
sometime back by Albert Herranz, and I think they got included in 2.6.10-mm1 
as per:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm1/broken-out/
	 Albert's code was also posted on this site:
http://www.gc-linux.org/down/isobel/kexec/
	ppc64 kexec kernel support was added recently (2.6.12-rc4-mm1)
	Eric's site can be used for downloading the kexec-tools.
	
	You may want to cross post kexec discussion mails to fastboot@osdl.org,
as that is the primary list where all kexec discussions happen.

Hope this helps
Thanks and Regards,
Sharada

On Thu, Oct 20, 2005 at 11:03:52PM -0600, Christopher Friesen wrote:
> 
> I've been asked to look at kexec for ppc on 2.6.10.  The syscall appears 
> to be present, but there seem to be additional patches for 2.6.10-mm at:
> 
> http://www.xmission.com/~ebiederm/files/kexec/
> 
> Are these patches needed?
> 
> I haven't been able to find any current official documentation, although 
> I found some old stuff from 2.5 and a writeup at:
> 
> http://www-128.ibm.com/developerworks/linux/library/l-kexec.html?ca=dgr-lnxw04RebootFast
> 
> Is there any official HOWTO on this?  Any issues I should look at in 
> particular?
> 
> Thanks for any pointers,
> 
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
