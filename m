Return-Path: <annamaya@yahoo.com>
Received: from web53804.mail.yahoo.com (web53804.mail.yahoo.com
	[206.190.36.199]) by ozlabs.org (Postfix) with SMTP id 3557C2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 07:23:09 +1000 (EST)
Message-ID: <20041013212308.47899.qmail@web53804.mail.yahoo.com>
Date: Wed, 13 Oct 2004 14:23:08 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <913DC44A-1D5D-11D9-88FA-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Song <samlinuxppc@yahoo.com.cn>, linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I verified that the TX and RX clock signals are
correct and the CMXFCR route register is programmed
correctly for FCC2. I still see TX timeout errors. I
am stumped. :-(

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Oct 13, 2004, at 3:21 PM, annamaya wrote:
> 
> > I looked at the driver again and it looks like the
> TX
> > and RX clock signals are board specific. I will
> also
> > have to program the CMXFCR clock route register
> with
> > the appropriate clocks. Am I on the right track
> here?
> 
> Yep. :-)
> 
> 
> 	-- Dan
> 
> 



		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com
