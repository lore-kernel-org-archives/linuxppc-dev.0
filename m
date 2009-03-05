Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B214BDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 18:42:01 +1100 (EST)
MIME-Version: 1.0
Date: Thu, 05 Mar 2009 08:41:55 +0100
From: Michael Guntsche <mike@it-loops.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PHY not found after migration of gianfar driver to an
	=?UTF-8?Q?of=5Fplatform=5Fdriver?=
In-Reply-To: <fa686aa40903040757n3992fec4jb6f3b75396af2958@mail.gmail.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
	<9d38520266f15d80352d1554e63c1ce6@localhost>
	<a57485706bfc7aae2295acd743445312@localhost>
	<fa686aa40903030723p7d82edbfg5928adf9fe108b01@mail.gmail.com>
	<7AC161D8-83A8-4330-A2CF-3120F15D9038@it-loops.com>
	<fa686aa40903031310o4e0c0b2bnba0544012b0fb8bc@mail.gmail.com>
	<68DDAAA9-42AF-4E9C-907C-7D3269816184@it-loops.com>
	<fa686aa40903040757n3992fec4jb6f3b75396af2958@mail.gmail.com>
Message-ID: <20e286be3bc61f03018fc94366e6fd01@localhost>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Mar 2009 08:57:59 -0700, Grant Likely <grant.likely@secretlab.ca>
wrote:
> You might be able to use of_attach_node() & prom_add_property() to
> modify the tree, but I've never done it myself.  Give it a try and
> tell me if it works.  :-)
> 

Hello Grant,

I made some progress in this area, but I have now hit a problem I do not
know how to solve.
Taking code from the iseries/vio.c files I am able to add properties with
add_string_property and add_raw_property. 
The problem I have is adding properties like

    reg = <0x2520 0x20>

I know how to add a property

   reg = <0x2520>

but I do not know what data structure to pass to add_raw_property to add
two numbers there.

Kind regards,
Michael
