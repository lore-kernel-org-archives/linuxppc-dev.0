Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id B1FB867A78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 09:08:24 +1100 (EST)
Message-ID: <20050119220819.24822.qmail@web53805.mail.yahoo.com>
Date: Wed, 19 Jan 2005 14:08:18 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Input to the timerclk on the MPC8280
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've asked this question on this forum before but it
did not get answered. I tried asking the same question
in the U-Boot forum with no results. So, I am going to
try this again.

According to section 4.1.2 on Page 4-4 in the MPC8280
User's Manual, one should be able to use a combination
of  external clocks on Port C pins 25, 26, 27 and 29,
the CPM cloak and BRG1 to generate a 32KHz or a 4MHz
clock. I am unable to find  any code in u-boot or any
other place that initializes any of these pins to be
external clocks. And as for BRG1, I believe it is
being used for the SMC clock.

I am unable to understand how this is done. Can we
have a timerclk input WITHOUT an external clock
signal? Can I just use the CPM clock to generate this?
How is this being done in U-Boot now?

Thanks much for your help. I really need an answer to
this. 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
