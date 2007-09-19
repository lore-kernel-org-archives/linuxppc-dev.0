Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2402DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 00:08:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8JE8j2t009485
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Sep 2007 10:08:45 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8JE6EFh432112
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Sep 2007 08:08:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8JE2A4T031128
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Sep 2007 08:02:10 -0600
Date: Wed, 19 Sep 2007 09:02:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "- Reyneke" <reynekejunk@hotmail.com>
Subject: Re: Eth1 init and link status
Message-ID: <20070919090208.17b4a90b@weaponx.rchland.ibm.com>
In-Reply-To: <BAY101-F3306F36C70FAA4D450C466BEB90@phx.gbl>
References: <BAY101-F3306F36C70FAA4D450C466BEB90@phx.gbl>
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

On Wed, 19 Sep 2007 13:54:35 +0000
"- Reyneke" <reynekejunk@hotmail.com> wrote:

> HI,
> 
> We've run into a bit of an odd problem and we are not sure where to go and 
> look for the cause.
> 
> We have some 440EPx based hardware with two GIG-Ethernet ports using RGMII 
> and 2x ET1011C PHY's. Problem is that eth1 will only initialise correctly 
> (i.e. receive and transmit) if eth0 has a link. Eth0 always work OK, 
> regardless of eth1 status. Eth1 will work OK if eth0 has a link (i.e. 
> initialised) at time of setup. Once initialised, eth0 status is irrelevant. 
> All this is during Linux boot process.
> 
> Any ideas?
> 
> We can access PHY registers via u-boot (mii commands). Same 1Gig link speed 
> is used on both ports. Linux kernel is 2.6.19.

Where did you get your kernel from?  2.6.19 doesn't have any 440EPx
support in it.  Maybe you should ask your vendor.

josh
