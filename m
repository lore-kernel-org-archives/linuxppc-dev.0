Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17480.51661.41707.53706@cargo.ozlabs.ibm.com>
Date: Fri, 21 Apr 2006 22:02:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH] powerpc/pseries: avoid crash in PCI code if mem system
	not up.
In-Reply-To: <20060421004042.GC7242@austin.ibm.com>
References: <20060421004042.GC7242@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> Please apply and forward upstream.  And a question: once 
> upon a time, the arch PCI subsystem was inited after mem init 
> was done; currently, it seems to be happening before mem init. 
> Is this intentional? 

No, and it is bogus if it is.  Do you have the full backtrace from the
crash?

Paul.
