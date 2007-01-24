Return-Path: <frannk_m1@yahoo.com>
Received: from web32203.mail.mud.yahoo.com (web32203.mail.mud.yahoo.com
	[68.142.207.134]) by ozlabs.org (Postfix) with SMTP id EA387DE0F4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 09:02:53 +1100 (EST)
Date: Wed, 24 Jan 2007 14:02:52 -0800 (PST)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: JTAG emulator for MPC8548E (v2)
To: Eugene Surovegin <ebs@ebshome.net>,
	Laurent Pinchart <laurent.pinchart@technotrade.biz>
In-Reply-To: <20070124103548.GA31703@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <139900.34585.qm@web32203.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org, "Morrison, Tom" <tmorrison@empirix.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Eugene Surovegin <ebs@ebshome.net> wrote:

> On Wed, Jan 24, 2007 at 08:57:19AM +0100, Laurent Pinchart
> wrote:
> > The new unit works *mostly* fine. No debugging issue (not
> that I use it that 
> > much anyway, now that the board boots Linux), but still a
> flash programming 
> > issue. Programming the target parallel NOR flash works in
> slow JTAG mode, but 
> > not in faster mode using the internal workspace. I reported
> the problem 
> > several months ago and still haven't received any solution.
> 
> Most likely problem isn't in BDI but in your setup. Depending
> on 
> the particular chip model, to be able use workspace you must
> have 
> initialized memory first. In fact, I'm pretty sure you haven't
> 
> configured chip correctly to make workspace usable. I've been
> using 
> BDI with various PowerPC and MIPS SoCs for many years. It's an
> excellent 
> tool, you just have to use it correctly.
> 
> -- 
> Eugene
> 
I totally agree. I have also been using the BDI 2000 for several
years on PPC,ARM,MIPS and Xscale and have never had a problem.


 
____________________________________________________________________________________
It's here! Your new message!  
Get new email alerts with the free Yahoo! Toolbar.
http://tools.search.yahoo.com/toolbar/features/mail/
