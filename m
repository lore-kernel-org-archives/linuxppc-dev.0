Return-Path: <annamaya@yahoo.com>
Received: from web53806.mail.yahoo.com (web53806.mail.yahoo.com
	[206.190.36.201]) by ozlabs.org (Postfix) with SMTP id 291F32BF10
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Dec 2004 02:56:38 +1100 (EST)
Message-ID: <20041217155637.27997.qmail@web53806.mail.yahoo.com>
Date: Fri, 17 Dec 2004 07:56:37 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20041215171824.97038.qmail@web53805.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Initialization of Timer Clock on the MPC8260 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK Wolfgang. Noone has posted an answer to this
question in the U-Boot mailing list. So, I still need
help with this. :-)

I am looking at the support for one of your own
boards, the TQM8260. I dont see PC25, PC27 and PC26
being configured anywhere. And PC29 is configured as
an SCC1 CLSN signal. Therefore, I think the internal
BRGCLK is used as an input to the timerclk. Now, if
this was true, BRGC1 should have been programmed to
generate either 4MHz or 32KHz clock. But I dont see
this being done anywhere else in the code. I am
missing something and I am not sure what that is.

Thanks much for your help.


--- annamaya <annamaya@yahoo.com> wrote:

> Hello Wolfgang,
> 
> I will surely post this in the U-Boot forums. I just
> did not know where it was but I think I've found it
> now. I still had the address to the PPCBOOT mailist
> lists. I miss the good old days. :-)
> 
> And to answer you questions, yes, I did look at the
> GPIO pins for all the 8260 boards and not one of
> them
> was configured to be a clock. And I was unable to
> find
> the setbrg() routine elsewhere to set brgc1 to be
> the
> input for timerclk.
> 
> -Navin.
> 
> --- Wolfgang Denk <wd@denx.de> wrote:
> 
> > In message
> >
> <20041214230712.79751.qmail@web53805.mail.yahoo.com>
> > you wrote:
> > > I am not sure if this is the right place to ask
> > this
> > > question since this may be a U-Boot question. I
> am
> > 
> > Why do you ask here and not on the U-Boot mailing
> > list then?
> > 
> > > trying to understand how the source for the
> timer
> > > clock is selected on this processor. Figure 4-3
> > tries
> > > to explain this but I am unable to find code in
> > U-Boot
> > > that actually sets either BRG1 or one of the
> GPIO
> > pins
> > > to act as inputs for the timer clock generation.
> > Can
> > > someone point me to the right place in the code
> > where
> > 
> > Well, did you check the place where all GPIO pins
> > get initialized, i. e. board/<name>/<name>.c ?
> > 
> > Best regards,
> > 
> > Wolfgang Denk
> > 
> > -- 
> > Software Engineering:  Embedded and Realtime
> > Systems,  Embedded Linux
> > Phone: (+49)-8142-66989-10 Fax:
> (+49)-8142-66989-80
> > Email: wd@denx.de
> > "To take a significant step forward, you must make
> a
> > series of finite
> > improvements." - Donald J. Atwood, General Motors
> > 
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> The all-new My Yahoo! - Get yours free! 
> http://my.yahoo.com 
>  
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
