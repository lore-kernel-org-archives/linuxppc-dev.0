Return-Path: <michael@ellerman.id.au>
Date: Thu, 11 Jul 2013 16:58:08 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130711065807.GA26495@concordia>
References: <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
 <20130709081434.GI25631@dyad.programming.kicks-ass.net>
 <20130710030926.GD7491@concordia>
 <20130710083435.GA24070@gmail.com>
 <alpine.DEB.2.10.1307110039560.26051@vincent-weaver-1.um.maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1307110039560.26051@vincent-weaver-1.um.maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Vince Weaver <vince@deater.net>,
 acme@redhat.com, paulus@samba.org, xiaoguangrong@linux.vnet.ibm.com,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 11, 2013 at 12:42:31AM -0400, Vince Weaver wrote:
> On Wed, 10 Jul 2013, Ingo Molnar wrote:
> 
> > Exactly - PMUs enumerated in /sys should be self-identifying, it's a 
> > hardware topology after all ...
> > 
> > Anytime userspace is forced to look into /proc, or into weird places in 
> > /sys it's a FAIL really.
> 
> well on x86 you have to look at /proc/cpuinfo to get the 
> vendor/family/model number.  Should we add some specifier under sys?
> It's probably too late though as all userspace event libs will have
> to look at /proc/cpuinfo anyway to be backwards compatible.

If it's a new library implementing a new feature then no I don't think
it needs to be backward compatible. It's just a choice the library makes
as to what extent it depends on new kernel features.

cheers
