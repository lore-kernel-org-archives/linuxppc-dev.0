Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id 963152BDA2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 17:57:10 +1000 (EST)
Message-ID: <51DB8827D393D411BB69003048003F46FDCF2B@tvesntr.televes.com>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: 'Dan Malek' <dan@embeddededge.com>
Date: Wed, 13 Oct 2004 09:54:52 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: Bridge, promiscous mode andCPM2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

So,

Is this patch available? Will it be available soon or applied to any ppc
kernel tree?
This is in my to-do list for the near future, so it would be very helpful if
this were already done.

Best regards,

Alex

> -----Original Message-----
> From:	Dan Malek [SMTP:dan@embeddededge.com]
> Sent:	Friday, October 08, 2004 5:40 PM
> To:	Rune Torgersen
> Cc:	alebas@televes.com; linuxppc-embedded@ozlabs.org
> Subject:	Re: Bridge, promiscous mode andCPM2
> 
> 
> On Oct 8, 2004, at 10:02 AM, Rune Torgersen wrote:
> 
> > Assuming CPM2 => 82xx or 85xx CPU.
> 
> Yes.
> 
> > I have no idea who or why that early return was put in,
> > but it does disable multicast and promiscous mode
> > on the FCC ethernets.
> 
> Because I never wrote (or lifted from somewhere else)
> the function to run the CRC generator for creating the
> multicast filters (the CPM1 on 8xx has hardware support
> for this).  I left the function there as a  place holder to get
> promiscuous mode, and someone did finish that function.
> It should be in one of the several kernel source trees......
> If not, I'll try to find the patch and do it again.
> 
> 
> 	-- Dan
