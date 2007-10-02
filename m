Return-Path: <mgreer@mvista.com>
Date: Mon, 1 Oct 2007 17:15:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] Get rid of linuxppc-embedded?
Message-ID: <20071002001509.GA11277@mag.az.mvista.com>
References: <20071001192459.GB5785@mag.az.mvista.com>
	<fa686aa40710011359x188d2930y38cd8a6faacb0f26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710011359x188d2930y38cd8a6faacb0f26@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 01, 2007 at 02:59:14PM -0600, Grant Likely wrote:
> On 10/1/07, Mark A. Greer <mgreer@mvista.com> wrote:
> > With the merging of the powerpc trees I'm not sure there is a clear
> > reason why we have 2 separate powerpc lists anymore (linuxppc-dev and
> > linuxppc-embedded).
> >
> > linuxppc-embedded is fairly low volume/noise but there is still the occasional
> > patch posted there that should really be posted to linuxppc-dev.  I think
> > it would be nice to have just one list where all eyes are focused.
> >
> > Is it time to get rid of linuxppc-embedded?
> 
> Ack Ack Ack!
> 
> I agree 100%

Okay.  Even if we keep the list around, we should update MAINTAINERS to
only refer to -dev.  I'll post a patch in a second.

Mark
