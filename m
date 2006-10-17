Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A30DF67C09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 06:37:59 +1000 (EST)
To: Andrea Galbusera <andrea.galbusera@teamware.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: JFFS2 on Lite5200 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Oct 2006 12:33:03 +0200."
	<1161081183.22948.58.camel@localhost.localdomain>
Date: Tue, 17 Oct 2006 22:37:57 +0200
Sender: wd@denx.de
Message-Id: <20061017203757.0C533353602@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1161081183.22948.58.camel@localhost.localdomain> you wrote:
> 
> I'm currently using linux-2.6.16 from denx on a Lite5200 V2.0. I need to
> access a JFFS2 filesystem on the onboard flash ( 16MB Am29L652D ).

We do NOT support the MPC5200 in the context of this kernel tree yet.

For the MPC5200, we still recommend  to  use  the  linuxppc_2_4_devel
tree.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The whole problem with the world is  that  fools  and  fanatics  are
always so certain of themselves, but wiser people so full of doubts."
- Bertrand Russell
