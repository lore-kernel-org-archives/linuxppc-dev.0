Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id 8962F2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Dec 2004 10:07:14 +1100 (EST)
Message-ID: <20041214230712.79751.qmail@web53805.mail.yahoo.com>
Date: Tue, 14 Dec 2004 15:07:12 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Initialization of Timer Clock on the MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am not sure if this is the right place to ask this
question since this may be a U-Boot question. I am
trying to understand how the source for the timer
clock is selected on this processor. Figure 4-3 tries
to explain this but I am unable to find code in U-Boot
that actually sets either BRG1 or one of the GPIO pins
to act as inputs for the timer clock generation. Can
someone point me to the right place in the code where
this is done? I think I  know how to do it but I fail
to understand where this is being actually done. All I
see is the settings of PISCR and TMCNT registers in
cpu initialization code. Thanks for your help in advance.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
