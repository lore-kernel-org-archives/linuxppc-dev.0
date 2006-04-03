Return-Path: <pj@sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 6EEE367A40
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 15:38:24 +1000 (EST)
Date: Sun, 2 Apr 2006 22:15:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-Id: <20060402221513.96f05bdc.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, ak@suse.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for_each_online_cpu(cpu) {

Idle curiosity -- what keeps a cpu from going offline during
this scan, and leaving us with the same crash as before?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
