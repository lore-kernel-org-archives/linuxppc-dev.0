Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id 3DF942BF10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 04:18:25 +1100 (EST)
Message-ID: <20041215171824.97038.qmail@web53805.mail.yahoo.com>
Date: Wed, 15 Dec 2004 09:18:24 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20041215162843.8DFC4C1430@atlas.denx.de>
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

Hello Wolfgang,

I will surely post this in the U-Boot forums. I just
did not know where it was but I think I've found it
now. I still had the address to the PPCBOOT mailist
lists. I miss the good old days. :-)

And to answer you questions, yes, I did look at the
GPIO pins for all the 8260 boards and not one of them
was configured to be a clock. And I was unable to find
the setbrg() routine elsewhere to set brgc1 to be the
input for timerclk.

-Navin.

--- Wolfgang Denk <wd@denx.de> wrote:

> In message
> <20041214230712.79751.qmail@web53805.mail.yahoo.com>
> you wrote:
> > I am not sure if this is the right place to ask
> this
> > question since this may be a U-Boot question. I am
> 
> Why do you ask here and not on the U-Boot mailing
> list then?
> 
> > trying to understand how the source for the timer
> > clock is selected on this processor. Figure 4-3
> tries
> > to explain this but I am unable to find code in
> U-Boot
> > that actually sets either BRG1 or one of the GPIO
> pins
> > to act as inputs for the timer clock generation.
> Can
> > someone point me to the right place in the code
> where
> 
> Well, did you check the place where all GPIO pins
> get initialized, i. e. board/<name>/<name>.c ?
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80
> Email: wd@denx.de
> "To take a significant step forward, you must make a
> series of finite
> improvements." - Donald J. Atwood, General Motors
> 



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 
