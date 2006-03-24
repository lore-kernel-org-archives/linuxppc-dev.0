Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200603240946.51793.arnd@arndb.de>
References: <1143178947.4257.78.camel@localhost.localdomain>
	<20060324062624.GA16815@pb15.lixom.net>
	<1143187298.3710.3.camel@localhost.localdomain>
	<200603240946.51793.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <54442245-B303-41F9-9E99-D8B6386B34C2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Kill machine numbers
Date: Fri, 24 Mar 2006 13:23:32 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> One thing I have been wondering about is what should be the right way
> to check whether we're running on something based on the
> Cell Broadband Engine Architecture, if that is needed somewhere.
> My original idea was to make this the platform number, but this
> seems impractical now.

Just check the PVR?  Either directly, or in the device tree.
It's not likely that there will be a million different CBEA
compliant CPUs any time soon ;-)

There really should be some other OF property in the CPU nodes
that tells us the CPU is CBEA, but I don't think we have one
right now :-(


Segher
