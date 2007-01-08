Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0206ADDE00
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 04:24:43 +1100 (EST)
Message-ID: <45A27E50.6040102@genesi-usa.com>
Date: Mon, 08 Jan 2007 17:24:32 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>	
	<1166558300.19254.71.camel@localhost.localdomain>	
	<1167773388.22068.443.camel@pmac.infradead.org>	
	<1167773863.6165.82.camel@localhost.localdomain>	
	<1167775493.3660.23.camel@shinybook.infradead.org>	
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>	
	<45A01416.6080401@genesi-usa.com>	
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	
	<45A1535C.1080007@genesi-usa.com>
	<1168222654.14763.92.camel@shinybook.infradead.org>
	<45A20C66.8060506@genesi-usa.com> <45A23E8E.7010209@246tNt.com>
In-Reply-To: <45A23E8E.7010209@246tNt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, bbrv@genesi-usa.com,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sylvain Munaut wrote:
> Ok, let's try to at least be a little productive:
> 
>> We can't fix the 1.3 firmware, it's already on the
>> first production batch, end of story. 
 >
> You mean the new firmware can't be flashed to the old boards ?

I mean we don't have the new firmware out and there is two months
of Linux usage to go before it will be.. at least.. granted we will
be having this discussion of what will need to be changed or not
at that time, yet again, because of some other changes we make.

However, changing a string IS a big deal when it needs to be tested
and quality assured for a commercial release. If it makes no
difference at all, it is a lot easier and less time consuming simply
not to change it :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
