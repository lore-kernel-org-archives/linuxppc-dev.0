Return-Path: <blofeldus@yahoo.com>
Received: from web53501.mail.yahoo.com (web53501.mail.yahoo.com
	[206.190.37.62]) by ozlabs.org (Postfix) with SMTP id A3C132BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 28 Nov 2004 08:39:46 +1100 (EST)
Message-ID: <20041127213940.72317.qmail@web53501.mail.yahoo.com>
Date: Sat, 27 Nov 2004 13:39:40 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: tnt@246tNt.com
In-Reply-To: <20041116201654.GA3088@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Cache coherency with BestComm issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,
 By experimenting I have found that the BestComm and FEC work without
the cache flush provided CPU_FTR_MAYBE_CAN_NAP is removed from the
cputable (nap disables snooping) and that CPU_FTR_NEED_COHERENT is
added to the cputable (turns on "M" bit in BAT/PTE so that the XLB has
a chance of seeing a global transaction).

I don't know if that will work for all G2_LE cores, but it seems
required for the 5200.
-rb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
