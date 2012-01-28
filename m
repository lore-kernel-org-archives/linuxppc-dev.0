Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sat, 28 Jan 2012 10:05:25 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [RFCv2 01/14] irq_domain: add documentation and MAINTAINERS entry.
Message-ID: <20120128170525.GA2501@ponder.secretlab.ca>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <1327352870-14687-2-git-send-email-grant.likely@secretlab.ca>
 <4F1F02E5.3000605@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F1F02E5.3000605@xenotime.net>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2012 at 11:13:41AM -0800, Randy Dunlap wrote:
> On 01/23/2012 01:07 PM, Grant Likely wrote:
> > Documentation for irq_domain library which will be created in subsequent
> > patches.
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  Documentation/IRQ-domain.txt |  113 ++++++++++++++++++++++++++++++++++++++++++
> >  MAINTAINERS                  |    9 +++
> >  2 files changed, 122 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/IRQ-domain.txt
> > 
> > diff --git a/Documentation/IRQ-domain.txt b/Documentation/IRQ-domain.txt
> > new file mode 100644
> > index 0000000..247f32a
> > --- /dev/null
> > +++ b/Documentation/IRQ-domain.txt
> > @@ -0,0 +1,113 @@
> > +irq_domain interrupt number mapping library
> > +
> > +The current design of the Linux kernel uses a single large number
> > +space where each separate IRQ source is assigned a different number.
> > +This is simple when there is only one interrupt controller, but in
> > +systems with controllers the kernel must ensure that each one does not
> 
>            with multiple interrupt controllers,

Hi Randy.  Thanks for the comments.  I've made the changes and they'll appear
in v4 of the series.

g.
