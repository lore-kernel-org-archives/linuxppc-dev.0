Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id D650BDDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 09:50:24 +1100 (EST)
Date: Wed, 26 Nov 2008 17:50:22 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/5] powerpc: ftrace updates to previous patch series
In-Reply-To: <20081126215821.263324391@goodmis.org>
Message-ID: <alpine.DEB.1.10.0811261749310.1501@gandalf.stny.rr.com>
References: <20081126215821.263324391@goodmis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 26 Nov 2008, Steven Rostedt wrote:

> Paul,
> 
> This patch series addresses the issues you brought up as well as
> adds some more enhancements and fixes. This series is added on
> top of the previous patch series.
> 
> The new patches are: (and are posted now)
> 5987225... powerpc/ppc32: static ftrace fixes for PPC32

The new commit id with the fix in Author and SoB is:
fd90db4bdc1ccf71927365cd634188cec4d7b151
 powerpc/ppc32: static ftrace fixes for 

-- Steve

> 382d6db... powerpc: ftrace, use create_branch
> d7d0ab8... powerpc: ftrace, added missing icache flush
> 10ec622... powerpc: ftrace, fix cast aliasing and add code verification
> d208ca5... powerpc: ftrace, do nothing in mcount call for dyn ftrace
> 
> The patches you already commented on:
> 5c4f5d7... powerpc/ppc32: ftrace, dynamic ftrace to handle modules
> a73af3e... powerpc/ppc64: ftrace, handle module trampolines for dyn ftrace
> 009104f... powerpc: ftrace, use probe_kernel API to modify code
> a352036... powerpc: ftrace, convert to new dynamic ftrace arch API
> 6d07bb4... powerpc: ftrace, do not latency trace idle
> 
