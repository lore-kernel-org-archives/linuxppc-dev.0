Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B89DA68885
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 04:46:10 +1100 (EST)
In-Reply-To: <200512061941.37502.pantelis.antoniou@gmail.com>
References: <20051206160122.DC581353F5E@atlas.denx.de>
	<200512061941.37502.pantelis.antoniou@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <68904bfe3fc469b1fceb8c8df6a4d730@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 6 Dec 2005 09:45:39 -0800
To: pantelis.antoniou@gmail.com
Cc: linuxppc-embedded@ozlabs.org, Robert Applebaum <rapplebaum@silicontkx.com>
Subject: Re: [PATCH] Support 8xx based Silicon Turnkey XTc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 6, 2005, at 9:41 AM, Pantelis Antoniou wrote:

> Unfortunately is not possible. Due to the way the flash is mapped on 
> boot it
> is not possible to have it continuous. Believe me I've tried :)

I can take the blame for this :-)  We used the high boot address mode
which isn't good for the larger flashes due to the address aliasing.
I'm going to make an even bigger mess and in the next round of boards
will change to the low boot memory.  Fortunately, there aren't too many
of this first version of boards, and those of us that have them will 
just
have to adapt.  :-)

Thanks.

	-- Dan
