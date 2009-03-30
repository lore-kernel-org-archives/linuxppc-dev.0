Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83504.mail.sp1.yahoo.com (web83504.mail.sp1.yahoo.com
	[216.252.120.160]) by ozlabs.org (Postfix) with SMTP id 7061EDDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 08:11:56 +1100 (EST)
Message-ID: <21841.75975.qm@web83504.mail.sp1.yahoo.com>
Date: Mon, 30 Mar 2009 14:11:54 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Bootlog bug?
To: michael@ellerman.id.au
In-Reply-To: <1238107887.15460.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: ron_madrid@sbcglobal.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--- On Thu, 3/26/09, Michael Ellerman <michael@ellerman.id.au> wrote:

> From: Michael Ellerman <michael@ellerman.id.au>
> Subject: Re: Bootlog bug?
> To: ron_madrid@sbcglobal.net
> Cc: linuxppc-dev@ozlabs.org
> Date: Thursday, March 26, 2009, 3:51 PM
> On Thu, 2009-03-26 at 11:25 -0700, Ron Madrid wrote:
> > I have a little problem with my boot messages. 
> I'm not sure what this
> > is, but does anyone have any ideas as to what it could
> be or what
> > further information I could give to help track this
> down.  As of now
> > this is not manifesting itself, but I don't know
> what it might do.
> 
> You have ended up with a duplicate device, or duplicate
> device _name_,
> somehow.

Thank you.  I found my duplicate device!

Ron
