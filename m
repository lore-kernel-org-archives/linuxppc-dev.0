Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD783DDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 05:01:29 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l08I1GfC005907
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 19:01:16 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A2866B.5050400@246tNt.com>
Date: Mon, 08 Jan 2007 18:59:07 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
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
	<45A27E50.6040102@genesi-usa.com>
In-Reply-To: <45A27E50.6040102@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8
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

Matt Sealey wrote:
> I mean we don't have the new firmware out and there is two months
> of Linux usage to go before it will be.. at least.. granted we will
> be having this discussion of what will need to be changed or not
> at that time, yet again, because of some other changes we make.
Or maybe you could tell us now what you're planning to
change/add ...

If not, that will be exactly the same thing, if for whatever
reason we need more infos in the device tree and that's not
currently specified, we'll define some binding for what's
missing that will end up being incompatible with what you did
during 2 month in secret and in the mean time the whole driver/support
code will have been written based on what has been discussed in
public ...


> This will definitely change in the next firmware from the discussion I've
> had with Gerald.

Could you be a little more precise about what you're planning
on 'fixing' from the list I posted ? (like point 1, 2 but not 3.
Or 1a, 1b 2a & 2b ...) ...


    Sylvain
