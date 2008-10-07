Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 918FADE05C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 03:14:44 +1100 (EST)
Message-ID: <48EB8AF1.6020600@mvista.com>
Date: Tue, 07 Oct 2008 09:14:41 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] edac: mpc85xx: Add support for MPC8572
References: <1221866428-20621-1-git-send-email-ncase@xes-inc.com>
	<9AE5B028-CEB5-456A-B97F-834D0A9B665A@kernel.crashing.org>
In-Reply-To: <9AE5B028-CEB5-456A-B97F-834D0A9B665A@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Kilkenny <akilkenny@xes-inc.com>,
	Nate Case <ncase@xes-inc.com>, Doug Thompson <norsk5@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's an SVN+quilt tree via sourceforge for EDAC. I have asked Doug to push 
this patch upstream to the mm tree.

Kumar Gala wrote:
> 
> On Sep 19, 2008, at 6:20 PM, Nate Case wrote:
> 
>> From: Andrew Kilkenny <akilkenny@xes-inc.com>
>>
>> This adds support for the dual-core MPC8572 processor.  We have
>> to support making SPR changes on each core.  Also, since we can
>> have multiple memory controllers sharing an interrupt, flag the
>> interrupts with IRQF_SHARED.
>>
>> Signed-off-by: Andrew Kilkenny <akilkenny@xes-inc.com>
>> Signed-off-by: Nate Case <ncase@xes-inc.com>
>> ---
>> drivers/edac/mpc85xx_edac.c |   28 +++++++++++++++++++++++-----
>> 1 files changed, 23 insertions(+), 5 deletions(-)
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> 
> Guys, is there an edac git tree or something to create patches against?  
> I've got one I've been sitting on but it should be updated based on 
> Nate's patch.
> 
> - k


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
