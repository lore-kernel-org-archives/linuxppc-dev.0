Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4B61DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 10:48:34 +1100 (EST)
Message-Id: <E3C4695C-A2A9-4657-B771-97DFDD3F6ACE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080318170542.GA4099@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] Make 83xx perfmon support selectable
Date: Wed, 19 Mar 2008 18:48:12 -0500
References: <1204934343-5235-1-git-send-email-afleming@freescale.com>
	<20080318170542.GA4099@loki.buserror.net>
Cc: Paul Mackerras <paulus@samba.org>,
	Phillips Kim <Kim.Phillips@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 18, 2008, at 12:05 PM, Scott Wood wrote:

> On Fri, Mar 07, 2008 at 05:59:03PM -0600, Andy Fleming wrote:
>> Not all e300 cores support the performance monitors, and the ones
>> that don't will be confused by the mf/mtpmr instructions.  This
>> allows the support to be optional, so the 8349 can turn it off
>> while the 8379 can turn it on.  Sadly, those aren't config options,
>> so it will be left to the defconfigs and the users to make that
>> determination.
>
> So does this mean we can't do multiplatform of something with  
> perfmon and
> something without perfmon?  Seems like this should come from the  
> device
> tree, or PVR, or some other runtime check.

It possible if your binutils supports generating the instructions.  I  
believe Kim was going to look at doing a patch to use a #define  
MFPMR(x)/#define MTPMR() so we don't have to worry about toolchain  
versions.

- k
