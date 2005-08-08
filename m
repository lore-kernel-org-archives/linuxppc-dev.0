Return-Path: <jschopp@austin.ibm.com>
Message-ID: <42F79D89.3040709@austin.ibm.com>
Date: Mon, 08 Aug 2005 12:59:37 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
In-Reply-To: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't see the merge as changing the actual code that gets executed
> on any given platform very much, except in one respect: we are going
> to standardize on a flattened device tree as the way that information
> about the platform gets passed from the boot loader to the kernel.
> 
> Comments? Flames? :)

There are several userspace applications that parse the non-flat device 
tree in /proc/device-tree on pSeries.  While I like the idea of the 
flattened device tree I think we need to consider how many apps we are 
going to break with it.
