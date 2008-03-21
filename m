Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D3E8DDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 15:12:38 +1100 (EST)
Date: Fri, 21 Mar 2008 00:12:36 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: DTS question
Message-ID: <20080321001236.4e37bba4@lappy.seanm.ca>
In-Reply-To: <47E2E4A2.9000801@freescale.com>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Mar 2008 17:26:42 -0500
"Scott Wood" <scottwood@freescale.com> wrote:

> > 	ad7414 {
> > 		compatible = "ad7414";  
> 
> This should proabably have a manufacturer prefix.

I wondered about this. Since the AD from Analog Devices is built into
the part number, I didn't know if it was needed. And analog-devices is
pretty long ;)

But I am willing to put it in if it is necessary.

Cheers,
   Sean
