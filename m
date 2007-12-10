Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 10:17:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, David Gibson <dgibson@ozlabs.org>,
	Andrei Dolnikov <adolnikov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071210171731.GD19913@mag.az.mvista.com>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071203015018.GC26919@localhost.localdomain>
	<20071204021026.GB18903@mag.az.mvista.com>
	<20071204025032.GH32577@localhost.localdomain>
	<20071206232756.GB4719@mag.az.mvista.com>
	<20071208013309.GB8662@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071208013309.GB8662@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 08, 2007 at 12:33:09PM +1100, David Gibson wrote:
> On Thu, Dec 06, 2007 at 04:27:56PM -0700, Mark A. Greer wrote:
> > David, et. al.,
> > 
> > This is a big blob patch of what I've changed for the prpmc2800.  It
> > includes the necessary changes in the kernel which you can probably
> > ignore but they're there for reference.  If you like the dts, then I'll
> > split the blob up into logical pieces and Andrei can make similar
> > changes for the Katana Qp.
> > 
> > Let me know what you think.
> 
> Looks pretty reasonable.  I would have preferred that labels be
> uppercase by convention, to make them easier to pick out by eyeball,
> but I think that's a lost cause at this stage.

I can do that.  Thanks for the feedback.  I'll break the blob up into
pieces and submit with the labels in uppercase.

Thanks,

Mark
