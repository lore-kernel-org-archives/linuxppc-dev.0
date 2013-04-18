Return-Path: <michael@ellerman.id.au>
Date: Thu, 18 Apr 2013 15:58:42 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
Message-ID: <20130418055842.GA14456@concordia>
References: <5148C2B3.6010408@linux.vnet.ibm.com>
 <20130405062137.GA5082@concordia>
 <5162CEBE.1020607@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5162CEBE.1020607@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 08, 2013 at 11:05:50AM -0300, Adhemerval Zanella wrote:
> On 04/05/2013 03:21 AM, Michael Ellerman wrote:
> > On Tue, Mar 19, 2013 at 04:55:31PM -0300, Adhemerval Zanella wrote:
> >> Hi all,
> >>
> >> This patch implement the time syscall as vDSO. I have a glibc patch
> >> to use it as IFUNC (as latest gettimeofday patch). Below the perf
> >> numbers:
> >>
> >> Baseline PPC32: 380 nsec
> >> Baseline PPC64: 352 nsec
> >> vdso PPC32:      20 nsec
> >> vdso PPC64:      20 nsec
> >>
> >> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
> >> as well?
> > You did provide a 32-bit implementation. I take it you haven't tested
> > that though? Can you test it?
> 
> Hi,
> 
> I didn't build a 32 bit kernel, but I tested 32 bits binaries (that uses
> the VDSO32 implantation) without any issue. Performance gains are similar.

OK. Please send an updated version of the patch which a changelog
describing the testing you've done, and add your Signed-off-by to the
patch.

cheers
