Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 274C0DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 13:42:33 +1000 (EST)
Message-ID: <4636B71D.3040601@itee.uq.edu.au>
Date: Tue, 01 May 2007 13:42:21 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] SystemACE driver - abstract register ops
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
In-Reply-To: <528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, Stefan Roese <sr@denx.de>,
	Rick Moleres <rick.moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant,

Grant Likely wrote:
> On 4/27/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> 
>> Thanks for your work on the SystemACE driver - I'll be porting/merging
>> this across to MicroBlaze very shortly.
> 
> Very cool; I hope it works well.

Indeed it does - your latest patchset version of the systemACE driver 
"just works" on MicroBlaze 2.6.20

I have only tested the 16-bit buswidth (standard ML401 reference design).

> For your reading pleasure, I've attached the bus attachment changes
> that I've made in my tree.  I hope to get this driver accepted into
> mainline during the 2.6.22 merge window; so please get any comments
> you have back to me ASAP.

Acked-by: John Williams <jwilliams@itee.uq.edu.au>

John
