Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id D8A382BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 03:16:13 +1100 (EST)
Message-ID: <20050114161609.37891.qmail@web53805.mail.yahoo.com>
Date: Fri, 14 Jan 2005 08:16:09 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050114160743.74903C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK on a PowerPC host machine? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the reply Wolfgang. Can you give me a hint
on the kind of work that is required to make this work
for the PPC host?

--- Wolfgang Denk <wd@denx.de> wrote:

> In message
> <20050114155131.22836.qmail@web53809.mail.yahoo.com>
> you wrote:
> > I noticed that ELDK from denx does not support
> running
> > on a PowerPC host machine like the Power G4 or G5.
> > When I tried rebuilding it on a Power G4 with
> > YellowDog installed on it, it complained that the
> > PowerPC host machine is not supported. Why is this
> 
> Correct. PPC host are not supported yet. Also please
>  not  that  only
> RedHat-7.3 will work as a build host without
> additional tweaking.
> 
> > host architecture not supported? I also found out
> that
> 
> Little demand? We have seen less than 5 requests for
> this so far.
> 
> > MontaVista does not support the PowerPC host
> > architecture anymore which they did a while ago.
> What
> > seems to be the real reason for not supporting
> this?
> 
> Probably the same reason: little demand.
> 
> 
> Well: the ELDK is free software -  if  you  fix  the
>  existing  build
> problems  and  send  me  a  patch I promise to check
> it in on the CVS
> server (as long as it doesn't break anything). But
> don't expect  this
> to be an easy job.
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
> If only God would give me some clear sign! Like
> making a large  depo-
> sit in my name at a Swiss Bank.                     
>    - Woody Allen
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
