Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <boot-6-07.miltonm@bga.com>
References: <boot-6-07.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A1DA71CC-E44A-4DFF-A017-D91477D33FFA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/15] bootwrapper: Add kexec callable zImage wrapper
Date: Wed, 11 Jul 2007 01:16:47 +0200
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The memory node off the root with a name starting with "memory" must
> contain enough free memory (not in the reserved ranges) in the first
> reg range to uncompress the the kernel with padding.

There can be many nodes called "/memory".  You probably
want to use the node pointed to by /chosen/memory instead?


Segher
