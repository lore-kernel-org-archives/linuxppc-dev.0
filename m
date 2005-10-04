Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.2.203])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5661B68402
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 16:18:42 +1000 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j946IXq3014826
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Oct 2005 08:18:34 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43421F87.2070501@246tNt.com>
Date: Tue, 04 Oct 2005 08:21:59 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrew Dennison <andrewd.lists@gmail.com>
References: <81A66F72DCACD511B0600002A551BFCB08D9613C@kuumex05.barco.com>
	<54823def0510032131mee19acft6250ed99ce55ef21@mail.gmail.com>
In-Reply-To: <54823def0510032131mee19acft6250ed99ce55ef21@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 and pcmcia
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew Dennison wrote:
> On 10/3/05, Derycke, Johan <johan.derycke@barco.com> wrote:
> 
>>If there is anything you want me to test let me know...
>>Does it support 32bit cards?
> 
> 
> Cardbus support is a problem at the moment. Not sure if it's my
> hardware or a 5200 PCI configuration issue.

IIRC, there is an errata wrt configuration cycle thru bridges.

> Apparnetly it's working in 2.6 but I haven't had time to sort this out.

Is it ? not sure. I remember seeing a patch about it but it removed
the "always 32 bit access" in all cases and not just in the needed case
iirc. Make me think I forgot to sort that out ...


	Sylvain
