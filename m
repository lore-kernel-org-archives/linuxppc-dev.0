Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8F02DDFDE
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 09:06:58 +1100 (EST)
Message-Id: <1E3E0E6E-39A6-4DC5-BB38-0C66D96C9C75@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1236979602.25062.55.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC][PATCH v3] powerpc: e300c2/c3/c4 TLB errata workaround
Date: Fri, 13 Mar 2009 17:06:46 -0500
References: <1236957383-20240-1-git-send-email-galak@kernel.crashing.org>
	<1236979602.25062.55.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, david.jander@protonic.nl, wd@denx.de,
	gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 13, 2009, at 4:26 PM, Benjamin Herrenschmidt wrote:

>> +BEGIN_FTR_SECTION
>> +	b      TlbWo    /* Code for TLB-errata workaround doesn't fit  
>> here */
>> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_DTLB_SW_LRU)
>> +RFTlbWo:
>
> Can you use nicer label names ? :-)
>
> Also, that's a lot of code for such a hot path...
>
> Cheers,
> Ben.

The code needs reworking.  However, we are doing SW LRU, not sure how  
we reduce this in the hot path.

- k
