Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id ADA39679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 00:55:26 +1100 (EST)
Date: Tue, 7 Mar 2006 16:55:22 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "antonio.dibacco" <antonio.dibacco@aruba.it>
Subject: Re: fs_enet on 2.4 and 8xx_immap
Message-ID: <20060307165522.7936fd7b@vitb.ru.mvista.com>
In-Reply-To: <20060307131500.3467.qmail@mx1.aruba.it>
References: <20060307131500.3467.qmail@mx1.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 07 Mar 2006 13:15:00 GMT
"antonio.dibacco" <antonio.dibacco@aruba.it> wrote:

> I think that to make it work I need to update cpm8xx_t inserting the fec2 
> filed. Is this true? Could I use the 8xx_immap.h of a 2.6 kernel?
> 
Not exactly. I think you can borrow the structures from 2.6, but do a triple-check that the result offsets are the same.

> Bye,
> Antonio.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
