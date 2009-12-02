Return-Path: <albert_herranz@yahoo.es>
Received: from smtp111.mail.ukl.yahoo.com (smtp111.mail.ukl.yahoo.com
	[77.238.184.49]) by ozlabs.org (Postfix) with SMTP id 5E36BB6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 10:29:39 +1100 (EST)
Message-ID: <4B16F85B.8040603@yahoo.es>
Date: Thu, 03 Dec 2009 00:29:31 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 09/11] powerpc: gamecube/wii: flipper interrupt
	controller support
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>	
	<1259441037-15725-10-git-send-email-albert_herranz@yahoo.es>	
	<A6D0F7F3-74DB-42BE-BC1D-4C251A75CB16@kernel.crashing.org>	
	<4B15731E.3000109@yahoo.es> <1259787401.2076.1159.camel@pasglop>
In-Reply-To: <1259787401.2076.1159.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-01 at 20:48 +0100, Albert Herranz wrote:
>> This -1 should be NO_IRQ too.
>> I'll fix this in the next version.
> 
> No. The number you pass here is not a linux virq number, but a number in
> your HW numbering space that never represents a valid IRQ. In your case
> 0 (NO_IRQ is deprecated anyways) is a valid HW interrupt number. However
> -1 sounds good.
> 
> So your existing code is fine.
> 

Oh. Good to know.
Then I need to fix the other PIC driver :)

> Cheers,
> Ben.
> 

Thanks,
Albert
