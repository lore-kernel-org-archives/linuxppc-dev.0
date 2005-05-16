Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id B557A679F4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 01:39:46 +1000 (EST)
To: Alex Zeffertt <ajz@cambridgebroadband.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 May 2005 16:15:03 BST."
	<20050516161503.0081b1b0.ajz@cambridgebroadband.com>
Date: Mon, 16 May 2005 17:39:34 +0200
Sender: wd@denx.de
Message-Id: <20050516153939.6CF17C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Missing m8260_cpm_dpfree() 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050516161503.0081b1b0.ajz@cambridgebroadband.com> you wrote:
> 
> I have a question about the MPC8260 dual port RAM allocation routines.
> 
> In arch/ppc/8260_io/commproc.c this is a  m8260_cpm_dpalloc() routine,
> but the m8260_cpm_dpfree() routine is missing.  Does anybody know where
> I can find this?

It was never implemented.

We added this in the context of the 8xx tree, and submitted  it  here
at least twice. The patches were never accepted for the publich sourc
trees,  so  we  stopped  wasting  our  time on this. I think Pantelis
Antoniou (?) submitted similar code later, but I don't remember  what
happened to it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Good manners are the settled  medium  of  social,  as  specie  is  of
commercial, life; returns are equally expected for both.
           - Lord Chesterfield _Letters to his Son_, 25 December 1753
