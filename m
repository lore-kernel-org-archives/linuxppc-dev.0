Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 31 Jan 2012 17:07:42 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 00/25] irq_domain generalization and refinement
Message-ID: <20120201000742.GM22611@ponder.secretlab.ca>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <20120131045344.GA27609@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120131045344.GA27609@quad.lixom.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2012 at 08:53:44PM -0800, Olof Johansson wrote:
> On Fri, Jan 27, 2012 at 02:35:54PM -0700, Grant Likely wrote:
> > Hey everyone,
> > 
> > This patch series is ready for much wider consumption now.  I'd like
> > to get it into linux-next ASAP because there will be ARM board support
> > depending on it.  I'll wait a few days before I ask Stephen to pull
> > this in.
> > 
> > Stephen/Milton/Ben, any testing you can help with here would be
> > appreciated since you've got access to a wider variety of Power
> > machines than I do.
> 
> This series has been:
> 
> Tested-by: Olof Johansson <olof@lixom.net>
> 
> On powerpc/pasemi (it's the only one I still have easy access to).

Excellent, thanks Olof!

g.
