Return-Path: <mkravetz@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0652967B87
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 07:28:58 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6ILStjn015870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 17:28:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6ILStoo310294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 15:28:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6ILSslJ003916
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 15:28:54 -0600
Date: Tue, 18 Jul 2006 14:29:13 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060718212913.GB3091@w-mikek2.ibm.com>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060718204723.GA6104@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 01:47:23PM -0700, Mike Kravetz wrote:
> A small update from the last version.  By popular demand, both
> wall time (mftb) and cpu cycles(PURR) are collected for each call.
> It is interesting to see these two values side by side in the
> output files.

Arnd asked on IRC, so I thought others may be interested in a
sample output file.  Remember, there is one file per CPU. All
values are decimal.  First number is hcall # (in decimal), second
is number of calls, third is total time (mftb) and fourth is cpu
time (PURR).  Note that 'total times' are still in cycles and
can be converted to another format in user space.

[elm3b125]/sys/kernel/debug/hcall_inst >cat cpu0
4 140651 21538230 14456409
8 130064 11855094 9459178
24 14259 1496316 986702
32 1809 354584 315399
84 103 27196 17763
88 1046 108106 109322
100 2596 251229 205154
104 1 1040 1061
108 2208 320491 242708
116 2669 1030894 713272
220 2 532 510
224 130662 47508588184 169383891
228 5 2689902 4622
260 3018 261893 230753

-- 
Mike
