Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 13B0DDDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 06:27:52 +1100 (EST)
Message-ID: <478FAC8A.9050800@scram.de>
Date: Thu, 17 Jan 2008 20:29:14 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to master/for-2.6.25 branch of powerpc.git
References: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>	<20080117145903.GA4535@localhost.localdomain>
	<A1DA2145-E5AE-4A7D-83D4-D86F05A9F6DF@kernel.crashing.org>
In-Reply-To: <A1DA2145-E5AE-4A7D-83D4-D86F05A9F6DF@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

>> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048473.html
>>
>> ^^ fixed phy support for fs_enet. Needed for some other boards, I
>> presume.
> 
> Hmm, its vitaly picking this one up?  if not I can.

That would be great. Jeff Garzik agreed to have this patch go through the PowerPC tree and this
patch is dependent on the other fixed-phy patches.

Thanks,
Jochen
