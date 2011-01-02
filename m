Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B36E7B70DA
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2011 01:58:51 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: prasad@linux.vnet.ibm.com
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
	<m38w0c77vs.fsf@linux-m68k.org> <20101201043758.GA2219@in.ibm.com>
	<20101213082619.GA6582@in.ibm.com> <m2vd2x1ojj.fsf@igel.home>
	<20101214125427.GA2443@in.ibm.com> <m2oc8lhcik.fsf@igel.home>
	<20110102125401.GA2390@in.ibm.com>
Date: Sun, 02 Jan 2011 15:58:47 +0100
In-Reply-To: <20110102125401.GA2390@in.ibm.com> (K. Prasad's message of "Sun,
	2 Jan 2011 18:24:01 +0530")
Message-ID: <m2oc7z5p3s.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> The watch-vfork test actually fails on my system (4 unexpected failures)

It should pass all four tests.  If gdb cannot even set a watchpoint it
cannot trigger the crash, of course.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
