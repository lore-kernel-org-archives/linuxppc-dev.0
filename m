Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 16:15:09 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: Power7: Make CPI stack events available in sysfs
Message-ID: <20130415061508.GD21147@concordia>
References: <20130406164803.GA408@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130406164803.GA408@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 06, 2013 at 09:48:03AM -0700, Sukadev Bhattiprolu wrote:
> From bdeacf7175241f6c79b5b2be0fa6b20b0d0b7d1c Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Sat, 6 Apr 2013 08:48:26 -0700
> Subject: [PATCH] perf: Power7: Make CPI stack events available in sysfs
> 
> A set of Power7 events are often used for Cycles Per Instruction (CPI) stack
> analysis. Make these events available in sysfs (/sys/devices/cpu/events/) so
> they can be identified using their symbolic names:
> 
> 	perf stat -e 'cpu/PM_CMPLU_STALL_DCACHE_MISS/' /bin/ls

Should we take these two via the powerpc tree? Or do you want to take
them Arnaldo?

cheers
