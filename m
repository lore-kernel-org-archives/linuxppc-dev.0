Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id E661D67A71
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 02:29:01 +1100 (EST)
Message-ID: <421DF2B8.6040007@mvista.com>
Date: Thu, 24 Feb 2005 08:28:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
In-Reply-To: <20050224082508.GA30005@pegasos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: nd@bplan-gmbh.de, Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:

>On Tue, Jan 25, 2005 at 05:14:25PM -0700, Mark A. Greer wrote:
>  
>
>>Hi Andrew.
>>
>>This patch briges the mv64x60 related code up to the latest that I have.
>>    
>>
>
>Mark, ...
>
>I am a bit bewildered by what you are doing here. How does this mv64x60 code
>relate to the mv643xx_eth driver from the mips folk ? 
>
>Friendly,
>
>Sven Luther
>

Hi Sven.

The mv64x60 is a Marvell host bridge with some I/O ctlrs including 3 
enet cltrs.  There are virtually identical versions for MIPS (called 
mv64x4x) and PPC (called mv64x6x).  The mv643xx_eth driver was 
originally written by the MIPS folks, as you note, but Dale Farnsworth 
has spent a lot of time making it work on both MIPS and PPC.  The code 
you see in the mv64x60.c file is a part of that.  I believe that Dale's 
patch(es) have been accepted and are queued to go into the mainline tree 
at some point.

Did I answer your question?

Mark
