Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 867F42BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 01:38:57 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB7B@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB7B@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <435F9A02-1940-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 11:39:38 -0400
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org, alebas@televes.com
Subject: Re: Bridge, promiscous mode andCPM2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 10:02 AM, Rune Torgersen wrote:

> Assuming CPM2 => 82xx or 85xx CPU.

Yes.

> I have no idea who or why that early return was put in,
> but it does disable multicast and promiscous mode
> on the FCC ethernets.

Because I never wrote (or lifted from somewhere else)
the function to run the CRC generator for creating the
multicast filters (the CPM1 on 8xx has hardware support
for this).  I left the function there as a  place holder to get
promiscuous mode, and someone did finish that function.
It should be in one of the several kernel source trees......
If not, I'll try to find the patch and do it again.


	-- Dan
