Return-Path: <mpe@ellerman.id.au>
Message-ID: <1391757722.23461.6.camel@concordia>
Subject: Re: [PATCH V2] power7, perf: Make some new raw event codes
 available in sysfs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 07 Feb 2014 18:22:02 +1100
In-Reply-To: <52F1FB75.9090007@linux.vnet.ibm.com>
References: <52C4F303.80007@linux.vnet.ibm.com>
 <52F1FB75.9090007@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-02-05 at 14:21 +0530, Anshuman Khandual wrote:
> On 01/02/2014 10:32 AM, Anshuman Khandual wrote:
> > This patchset adds some missing event list for POWER7 PMU raw
> > events which are exported through sysfs interface. Also updates
> > the ABI documentation to add all the sysfs exported raw events.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > ---
> >  .../testing/sysfs-bus-event_source-devices-events  | 517 +++++++++++++++++++++
> >  arch/powerpc/perf/power7-events-list.h             |  10 +
> >  2 files changed, 527 insertions(+)
> 
> Hey Michael,
> 
> Any updates on this patch ? This does not seem to be merged yet.

No updates. I thought I asked Ben to merge it but I guess I didn't, or he
didn't. Will queue it up.

cheers
