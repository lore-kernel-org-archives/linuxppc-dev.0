Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 4290267A6B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 07:08:54 +1100 (EST)
To: Joakim.Tjernlund@lumentis.se
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Jan 2005 15:12:01 +0100."
	<BCEFJBPJCGFCNMMMIDBHOEPBCJAA.Joakim.Tjernlund@lumentis.se>
Date: Sun, 13 Feb 2005 21:08:42 +0100
Sender: wd@denx.de
Message-Id: <20050213200847.1AE42C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPU15 errata workaround for 8xx by WD 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Jocke,

sorry for the late reply.

In message <BCEFJBPJCGFCNMMMIDBHOEPBCJAA.Joakim.Tjernlund@lumentis.se> you wrote:
> 
> Had a look at your CPU15 errata workaround for 8xx and I have a comment
> or two:
> 
> 1) I think you should make the sysctl support a compile time option
>    as the overhead for sysctl support in the TLB handler is 6 instr. when
>    the fix itself is only 4 instr.

You are right.

> 2) You placed the workaround in the middle of the CPU6 workaround which will
>    disable the CPU6 workaround(I think). Move it before the #ifdef CONFIG_8xx_CPU6
>    and you should be fine.

You are right again - we fixed this in our CVS tree now.


Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The management question ... is not _whether_ to build a pilot  system
and  throw  it away. You _will_ do that. The only question is whether
to plan in advance to build a throwaway, or to promise to deliver the
throwaway to customers.       - Fred Brooks, "The Mythical Man Month"
