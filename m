Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443731A09CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 21:33:54 +1100 (AEDT)
Message-ID: <1447929223.11126.4.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Standardise on NR_syscalls rather than
 __NR_syscalls.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Denis Kirjanov
 <kda@linux-powerpc.org>, Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 19 Nov 2015 21:33:43 +1100
In-Reply-To: <564D9D85.1090201@linux.vnet.ibm.com>
References: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
 <CAOJe8K0yHTdymRbEo=itvK-AYiNzQLLspNgTyyzADkzpPxpzHw@mail.gmail.com>
 <564D9D85.1090201@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-19 at 15:29 +0530, Anshuman Khandual wrote:
> On 11/19/2015 02:45 PM, Denis Kirjanov wrote:
> > On 11/19/15, Rashmica Gupta <rashmicy@gmail.com> wrote:
> > > > Most architectures use NR_syscalls as the #define for the
> > > > number of
> > > > syscalls.
> > > > 
> > > > We use __NR_syscalls, and then define NR_syscalls as
> > > > __NR_syscalls.
> > > > 
> > > > __NR_syscalls is not used outside arch code, whereas
> > > > NR_syscalls is. So as
> > > > NR_syscalls must be defined and __NR_syscalls does not, replace
> > > > __NR_syscalls
> > > > with NR_syscalls.
> > Hi,
> > 
> > But what's wrong with the current code? Why do we need such change?
> 
> Yeah, just out of curiosity. Why we had both __NR_syscalls and
> NR_syscalls to begin with ?

Evolutionary remains. This is a whorthwhile and fairly simple cleanup.

Cheers,
Ben.
