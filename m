Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C723DDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:31:34 +1100 (EST)
Message-ID: <45D29EB1.5060801@freescale.com>
Date: Tue, 13 Feb 2007 23:31:29 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <1171409687840-git-send-email-timur@freescale.com>	
	<1171411075.20192.116.camel@localhost.localdomain>	
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
In-Reply-To: <1171430877.20192.133.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>> Only one DTS file has it.  It's been removed from every other DTS.  Are 
>> you should that instead of removing the last one, I should *add* one to 
>> the other DTS files?
> 
> Or just leave them alone for now.

Well, it's inconsistent.  If you *really* don't want me to remove the 
'chosen' node from this one DTS, I'll respin the patch without it.  But 
I just don't understand why it's okay to leave it there.
