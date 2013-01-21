Return-Path: <mgreer@animalcreek.com>
Date: Mon, 21 Jan 2013 11:30:50 -0700
From: "Mark A. Greer" <mgreer@animalcreek.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Anyone have a PrPmc 280/2800 handy?
Message-ID: <20130121183050.GA7998@animalcreek.com>
References: <20130117223343.GC32446@animalcreek.com>
 <CAP=VYLpyJZ3BYW6xrJOivQoXv3y7msiB5g7_puFw04UdMFW3zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP=VYLpyJZ3BYW6xrJOivQoXv3y7msiB5g7_puFw04UdMFW3zA@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 19, 2013 at 08:59:18PM -0500, Paul Gortmaker wrote:
> On Thu, Jan 17, 2013 at 5:33 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> > Hello.
> >
> > I want to make some fixups to the marvell hostbridge and
> > mpsc code and would like to test them on a PrPmc280/2800.
> > The problem is, I don't have one anymore.
> 
> Hi Mark,

Hi Paul.

> Is there another platform that uses mpsc that can be used for
> testing?  I ask because I did spend a lot of time with PrPMC-280
> and motload/powerboot; some standalone, some on ATCA-F101.
> And with that hindsight, I can't help thinking that the right thing
> to do some eight years later is to simply consider removing the
> support for these old platforms.  Would that make your validation
> easier?  If so, then I'd recommend it.  This is of course, just my opinion.

Hmm, yeah, the c2k platform uses that bridge too.  I'll see if I can find
someone with one of those handy.

Since nobody seems to have a prmpc280/2800 anymore, it does seem prudent
to remove it.  It would make validation easier for me in that its one less
platform to worry about breaking.  If I don't hear anything in the next
few days, I'll make a patches to remove prpmc280/2800 support.

Thanks,

Mark
--
