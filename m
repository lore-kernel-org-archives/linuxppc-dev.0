Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCF3B67C10
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 21:34:41 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA5AYWnR029061
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Nov 2006 11:34:32 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <454DBE2C.6040506@246tNt.com>
Date: Sun, 05 Nov 2006 11:34:20 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, idefix@fechner.net
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
References: <20061104163119.GC69112@server.idefix.loc>	<528646bc0611041832j327c8391i9d3401782529073d@mail.gmail.com>
	<20061105102328.GH79990@server.idefix.loc>
In-Reply-To: <20061105102328.GH79990@server.idefix.loc>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matthias Fechner wrote:
> Hello Grant,
>
> * Grant Likely <grant.likely@secretlab.ca> [04-11-06 20:32]:
>   
>> Yup, there exists patches for all the functionality that you're
>> looking for.  You can find them if you search the list, but I'll send
>> you a link to a git tree with all those patches in it later tonight.
>>     
>
> you maybe mean:
> http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git
>
> I tried that repository but here I was not able to patch the tree with
> Xenomai.
> But if you have another link it would be a pleasure for me to receive
> the link :)
>   
Take the patchs off that link (bestcomm branch), and apply them on a
fresh/recent
tree, that should work. (that is, clone a official tree, then pull from
the above link
and merge the two).

There is work in progress for the arch/powerpc port but it's not done yet.


    Sylvain
