Return-Path: <annamaya@yahoo.com>
Received: from web53807.mail.yahoo.com (web53807.mail.yahoo.com
	[206.190.36.202]) by ozlabs.org (Postfix) with SMTP id 285DE2BDA3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 05:21:37 +1000 (EST)
Message-ID: <20041013192135.72162.qmail@web53807.mail.yahoo.com>
Date: Wed, 13 Oct 2004 12:21:35 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: annamaya <annamaya@yahoo.com>, Dan Malek <dan@embeddededge.com>
In-Reply-To: <20041013180651.62847.qmail@web53804.mail.yahoo.com>
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

I looked at the driver again and it looks like the TX
and RX clock signals are board specific. I will also
have to program the CMXFCR clock route register with
the appropriate clocks. Am I on the right track here?

--- annamaya <annamaya@yahoo.com> wrote:

> I was able to use the same driver on a PQ2-FADS
> board
> with an MPC8275 processor. Are you telling me that
> some of these pins are board specific? Thanks for
> your
> help.
> 
> --- Dan Malek <dan@embeddededge.com> wrote:
> 
> > 
> > On Oct 13, 2004, at 10:49 AM, annamaya wrote:
> > 
> > > ..... But my driver doesn't work and complains
> > > about a TX timeout. I am sure I am missing
> > something.
> > > Can you suggest something that I could try?
> > 
> > You are going to have to track down the clock and
> > control signals for the FCC and make sure they are
> > still connected the same way as the 8260.  Sounds
> > like they aren't.  There are #defines at the top
> of
> > the
> > driver file that map the GPIO pins to the FCC
> > signals.
> > 
> > 
> > 	-- Dan
> > 
> > 
> 
> 
> 
> 		
> _______________________________
> Do you Yahoo!?
> Declare Yourself - Register online to vote today!
> http://vote.yahoo.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
