Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-37.bluehost.com (outbound-mail-37.bluehost.com
	[70.98.111.191]) by ozlabs.org (Postfix) with SMTP id CAA9C689C0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 16:12:24 +1100 (EST)
Message-ID: <43CF1F9A.9040705@secretlab.ca>
Date: Wed, 18 Jan 2006 22:11:54 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Peter Ryser <peter.ryser@xilinx.com>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <20060114094658.GA12639@secretlab.ca>
	<43CC5453.3060702@xilinx.com> <43CC9F35.8010305@secretlab.ca>
	<43CCE89B.8050603@xilinx.com> <43CD460F.8010506@secretlab.ca>
	<43CECEA4.4050908@xilinx.com>
In-Reply-To: <43CECEA4.4050908@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Grant Likely <grant@secretlab.ca>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Ryser wrote:
> 
>> Yeah, the head of Linus' tree is busted.  Doing a cg-seek 
>> 67daf5f11f06b9b15f8320de1d237ccc2e74fe43 will work, but you first need 
>> to remove the following line from arch/ppc/kernel/ppc_ksyms.c
>>
>> EXPORT_SYMBOL(get_wchan);
>>
> After applying your patches to the branch-point you mention above, 
> removing that symbol, and configuring for the ML403 I can get to a boot 
> prompt. Good.
> 
> Doing the same for the ML300, though, does not work, i.e. I get a single 
> line saying:
> "Data machine check in kernel mode."

update you git to 2.6.16-rc1, and apply this patch:

http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0301.html

Then apply the patches and try again.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
