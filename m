Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptcr3BNDzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:22:52 +1000 (AEST)
In-Reply-To: <20161122092033.7869-1-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [RFC,v2] powerpc: xmon: Add address lookup for percpu symbols
Message-Id: <41ptcr1qmxz9sBD@ozlabs.org>
Date: Mon, 13 Aug 2018 21:22:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 09:20:09 UTC, Boqun Feng wrote:
> Currently, in xmon, there is no obvious way to get an address for a
> percpu symbol for a particular cpu. Having such an ability would be good
> for debugging the system when percpu variables got involved.
> 
> Therefore, this patch introduces a new xmon command "lp" to lookup the
> address for percpu symbols. Usage of "lp" is similar to "ls", except
> that we could add a cpu number to choose the variable of which cpu we
> want to lookup. If no cpu number is given, lookup for current cpu.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/302c7b0c4ff5aed585419603f835de

cheers
