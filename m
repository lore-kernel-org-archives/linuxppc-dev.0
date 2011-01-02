Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C3D6B70D6
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jan 2011 23:54:09 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p02Cs5Wn031089
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Jan 2011 18:24:05 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p02Cs4Ae2949360
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Jan 2011 18:24:04 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p02Cs33m019525
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Jan 2011 18:24:04 +0530
Date: Sun, 2 Jan 2011 18:24:01 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
Message-ID: <20110102125401.GA2390@in.ibm.com>
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
	<m38w0c77vs.fsf@linux-m68k.org> <20101201043758.GA2219@in.ibm.com>
	<20101213082619.GA6582@in.ibm.com> <m2vd2x1ojj.fsf@igel.home>
	<20101214125427.GA2443@in.ibm.com> <m2oc8lhcik.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2oc8lhcik.fsf@igel.home>
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 16, 2010 at 06:07:47PM +0100, Andreas Schwab wrote:
> "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> 
> > How about the revised patch below? It is only compile-tested; have you
> > got a quick test case that I can run?
> 
> It crashes the kernel when running the watch-vfork test.
> 
> Andreas.
>

Hi Andreas,
	I tried running it multiple times but saw no crash (or error
messages in dmesg). Can you send me the crash logs? What's the behaviour
when the testcase is run on an unpatched kernel?

The watch-vfork test actually fails on my system (4 unexpected failures)
irrespective of the kernel containing the patch or not.

Thanks,
K.Prasad
P.S.: I'd been on vacation and couldn't look at this issue during then.
