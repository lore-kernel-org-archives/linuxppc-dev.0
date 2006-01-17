Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-21.bluehost.com (outbound-mail-21.bluehost.com
	[70.103.189.16]) by ozlabs.org (Postfix) with SMTP id A26F9689C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 06:31:45 +1100 (EST)
Message-ID: <43CD460F.8010506@secretlab.ca>
Date: Tue, 17 Jan 2006 12:31:27 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Peter Ryser <peter.ryser@xilinx.com>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <20060114094658.GA12639@secretlab.ca>
	<43CC5453.3060702@xilinx.com> <43CC9F35.8010305@secretlab.ca>
	<43CCE89B.8050603@xilinx.com>
In-Reply-To: <43CCE89B.8050603@xilinx.com>
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
>> Hmm, did you use the ml403 and ml300 def configs?  What date did you 
>> pull Linus' tree?  Kumar and Paul were talking today about some serial 
>> subsystem breakage on the linux-2.6 tree this weekend... I'll fast 
>> forward tonight and try it on my board. 
> 
> 
> Okay, please let me know how this works for you.

Yeah, the head of Linus' tree is busted.  Doing a cg-seek 
67daf5f11f06b9b15f8320de1d237ccc2e74fe43 will work, but you first need 
to remove the following line from arch/ppc/kernel/ppc_ksyms.c

EXPORT_SYMBOL(get_wchan);

The fix will be in post -rc1

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
