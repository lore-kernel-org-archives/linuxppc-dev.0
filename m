Return-Path: <tnt@246tNt.com>
Received: from outmx003.isp.belgacom.be (outmx003.isp.belgacom.be
	[195.238.2.100]) by ozlabs.org (Postfix) with ESMTP id E3CBD2BF1F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Jan 2005 09:38:51 +1100 (EST)
Received: from outmx003.isp.belgacom.be (localhost [127.0.0.1])
	by outmx003.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j01MclA8012693
	for <linuxppc-embedded@ozlabs.org>; Sat, 1 Jan 2005 23:38:47 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41D7269E.1070906@246tNt.com>
Date: Sat, 01 Jan 2005 23:39:26 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
References: <200412301246.48870.david.jander@protonic.nl>	<C6D7331E-5A77-11D9-AECD-003065F9B7DC@embeddededge.com>
	<061001c4eeaf$0b5e1860$0301a8c0@chuck2>
In-Reply-To: <061001c4eeaf$0b5e1860$0301a8c0@chuck2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 PCI byte-swapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark Chambers wrote:

>I've just realized that the 5200 does byte-lane swapping
>on all PCI accesses.  That is, if you write a 32 bit word
>0x12345678, 0x12 will go out on byte 0, 0x34 on byte 1,
>etc.  Unfortunately, my target, a T.I. DM642, does not
>do this, so I've got a big/little endian mismatch.  A couple
>of questions if anybody knows:
>
>- Do all MPC8xxx processors do this - byte swap on
>all PCI accesses, not just configuration space?
>
>- Is there an elegant (simple) way to re-swap the bytes?
>It's not a big problem really, but if there were a way to 
>set LE mode on a particular page or something like that
>it might be worth it.
>
>  
>
I'm not sure of what you mean but look at the mapping
aroung pdf page 337 of the user manual. It's not configurable
as far as I can see.


    Sylvain
