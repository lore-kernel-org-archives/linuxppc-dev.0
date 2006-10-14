Return-Path: <gun_raj@yahoo.com>
Received: from web52413.mail.yahoo.com (web52413.mail.yahoo.com
	[206.190.48.176]) by ozlabs.org (Postfix) with SMTP id CAD8167BD5
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2006 00:04:27 +1000 (EST)
Message-ID: <20061014140425.13558.qmail@web52413.mail.yahoo.com>
Date: Sat, 14 Oct 2006 07:04:25 -0700 (PDT)
From: ganesh subramonian <gun_raj@yahoo.com>
Subject: Re: Handling machine check exception
To: Segher Boessenkool <segher@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1924CA98-A7C7-4FD2-9709-58EC9DD6BEB6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: ganesh subramonian <gun_raj@yahoo.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi
the g2core manual does not say that DAR gets updated
for a machine check exception, but the mpc866um.pdf
manual says so, and it actually does work on my target
board with mpc852t. but no such reference is made in
mpc8272rm.pdf(and dar doesnt get updated on my 8247
based board).

if i cannot find out which address caused the
exception, is there any way by which i can disable
machine check for a particular range of addresses.

thanks
ganesh

--- Segher Boessenkool <segher@kernel.crashing.org>
wrote:

> >> The G2 core definitely has a DAR register (SPR
> 19).
> >>
> >> Look on the Freescale site for G2CORERM.pdf -
> this is
> >> your reference manual, not the one specifically
> for the
> >> 8247.
> >
> > Is DAR set for a machine check ?
> 
> Not on these old cores.
> 
> 
> Segher
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
