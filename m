Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17997.17543.725526.907770@cargo.ozlabs.ibm.com>
Date: Fri, 18 May 2007 16:15:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
In-Reply-To: <5F8D37B3-5A2B-49D8-A7C2-615436EA66D3@kernel.crashing.org>
References: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
	<17996.13115.456275.413478@cargo.ozlabs.ibm.com>
	<5F8D37B3-5A2B-49D8-A7C2-615436EA66D3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Sorry for the headache, I thought I had built an ARCH=ppc kernel.   
> This is now fixed in my tree so if you haven't pulled it you'll get  
> the fix.
> 
> Also, added a ppc_ksysm.c fix to remove a duplicate export symbol.

Hmmm.  I had pulled your tree, and I ended up rebasing your commits on
top of Linus' current master and adding some more commits on top of
that.  I'm about to send a pull request to Linus for that lot.  The
arch/ppc changes can go in the next lot.

Paul.
