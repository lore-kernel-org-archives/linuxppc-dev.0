Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D44267C60
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:41:53 +1000 (EST)
In-Reply-To: <1159899616.14294.127.camel@cashmere.sps.mot.com>
References: <20060928160211.5b652932.kim.phillips@freescale.com>
	<229C6ACA-4728-408B-9360-54249996E821@kernel.crashing.org>
	<1159899616.14294.127.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FD1E5D80-F1D1-4ED5-9166-E4AED9347634@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/2] remove mpc83xx support from arch/ppc
Date: Tue, 3 Oct 2006 13:42:08 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 1:20 PM, Jon Loeliger wrote:

> On Thu, 2006-09-28 at 16:34, Kumar Gala wrote:
>> On Sep 28, 2006, at 4:02 PM, Kim Phillips wrote:
>>
>>> remove 83xx support from arch/ppc.  Tested multiple arch/defconfig
>>> build combinations ok.  AFAICT, everything 83xx works in arch/
>>> powerpc, and new derivatives are being added only to arch/powerpc,
>>> so it's better not to keep this around.
>>
>> NACK!! we need the cuImage stuff working and in the tree before I'm
>> ok with this.  We have to be able to boot from a non-flat-dev  
>> aware u-
>> boot before I'll be ok with removing 83xx from arch/ppc.
>>
>> - kumar
>
> Any idea when those patches are going to be in?

Not sure, I wasn't sure if there were changes required to the patches  
for all the flat dev tree code going into the tree.

- k
