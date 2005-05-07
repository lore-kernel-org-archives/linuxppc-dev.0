Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 4DAFA679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 04:39:38 +1000 (EST)
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 07 May 2005 20:24:01 +0200."
	<JPEALJAFNGDDLOPNDIEECEAKDDAA.joakim.tjernlund@lumentis.se>
Date: Sat, 07 May 2005 20:39:08 +0200
Sender: wd@denx.de
Message-Id: <20050507183913.A7238C1512@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: How to fix 8xx dcbst bug? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <JPEALJAFNGDDLOPNDIEECEAKDDAA.joakim.tjernlund@lumentis.se> you wrote:
>
...
> safe, just look at ld.so. This should not be a requirement but for 8xx it is currently and I think 8xx gets
> away with it because nobody is using swap on 8xx.

I understand that the "not using swap" refers to 2.6 kernel only, right?

Because on 2.4, we use swap on several systems quite heavily. I  have
to admit that we had to patch pgtable.h to get it work.

[In case anybody needs it: it's this patchset in our CVS tree:

	PatchSet 80
	Date: 2003/08/24 14:58:59
	Author: wd
	Branch: HEAD
	Tag: (none)
	Log:
	Fix swap problem as observed on IVMS systems with IDE harddisk.
	
	Members:
	        include/asm-ppc/pgtable.h:1.6->1.7
]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Single tasking: Just Say No.
