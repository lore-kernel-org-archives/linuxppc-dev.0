Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17467.59608.503042.216312@cargo.ozlabs.ibm.com>
Date: Wed, 12 Apr 2006 03:35:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/2] tickless idle cpus: core patch - v2
In-Reply-To: <20060410121847.GB5564@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
	<20060410121847.GB5564@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srivatsa Vaddagiri writes:

> This is the v2 of the core patch to skip ticks when a CPU is idle.
> Changes since v1:
> 
> 	-  fix the buggy call to stop_hz_timer in idle_power4.S (hopefully it 
> 	   is correct now!).

It would be nice if we could arrange to call stop_hz_timer from the
top-level cpu_idle() function rather than having to call it from the
individual power_save() functions such as power4_idle().  Can you see
a problem with doing that?

Paul.
