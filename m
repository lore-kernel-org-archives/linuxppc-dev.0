Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id 680CC67CA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 04:08:18 +1000 (EST)
Message-ID: <51DB8827D393D411BB69003048003F4601B1C220@tvesntr>
From: Bastos Fernandez  Alexandre <ALEBAS@televes.com>
To: 'Pantelis Antoniou' <panto@intracom.gr>, Bryan O'Donoghue
	<typedef@eircom.net>
Date: Wed, 27 Jul 2005 20:08:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC885 - USB HCI drivers.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guys,

Finally, was the patch submitted to the list?
I have searched deeply both ozlabs and gmane, but I couldn't
find it ...

I have been disconnected from the list for several weeks (wedding holidays
:-) )
so I am a bit unplugged with all this stuff.
By now, I would apprece a lot this usb host driver for 82xx.

Thanks,

Alex BASTOS


> -----Original Message-----
> From:	Pantelis Antoniou [SMTP:panto@intracom.gr]
> Sent:	Tuesday, May 17, 2005 11:45 AM
> To:	Bryan O'Donoghue
> Cc:	linuxppc-embedded@ozlabs.org
> Subject:	Re: MPC885 - USB HCI drivers.
> 
> Bryan O'Donoghue wrote:
> > Pantelis Antoniou wrote:
> > 
> > 
> >>Well I have USB host drivers for both 8xx & 82xx working.
> > 
> > 
> > Speaking of which... would it not be a good idea, to get these comitted
> > to the 2.6 tree... at some stage ... at least to stop people
> > periodically posting to this list... saying "Dear all have spent 2
> > months, writing code for m8xx_hci drivers", when it's a needless
> > replication of effort ?
> > 
> 
> Well, they are too hideous for human eyes :)
> 
> > 
> >>However I use them connected to a specific peripheral
> >>so I don't know how well they fare when used as a PC
> >>style USB host controller.
> > 
> > 
> > Also, one easy way to find out, how well or badly said code performs, in
> > hetrogenous environments, is to... suck it and see.
> > 
> > As I was attempting to intimate above, I'm sure there'd be a legion of
> > eager people to debug, modify and recode such drivers, if there lived in
> > an obvious place... in the 2.6 tree.
> > 
> > Just my EUR0.02.
> > 
> 
> Also they're 2.4 only :)
> 
> I'll try to clean them up and post them sometime this week.
> 
> But I don't have time left to hack them for 2.6. I'll need
> vict^H^H^Holunteers to do it...
> 
> Regards
> 
> Pantelis
> 
> 
> > --
> > 
> > Best,
> > Bryan
> > 
> > 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
