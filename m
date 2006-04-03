Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id E4F1967A03
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 15:25:21 +1000 (EST)
Date: Sun, 2 Apr 2006 22:25:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
In-Reply-To: <20060402221513.96f05bdc.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
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

On Sun, 2 Apr 2006, Paul Jackson wrote:

> -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +		for_each_online_cpu(cpu) {
> 
> Idle curiosity -- what keeps a cpu from going offline during
> this scan, and leaving us with the same crash as before?

Nothing keeps a processor from going offline. We could take the hotplug 
lock for every for_each_online_cpu() in the kernel. Could you take that 
up with the hotplug folks?
