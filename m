Return-Path: <mgreer@mvista.com>
Date: Tue, 18 Dec 2007 14:35:06 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/8] powerpc: prpmc2800 - Convert dts file to v1
Message-ID: <20071218213506.GB30388@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
	<20071211003738.GB4995@mag.az.mvista.com>
	<20071214220335.GA21311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214220335.GA21311@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2007 at 09:03:35AM +1100, David Gibson wrote:
> On Mon, Dec 10, 2007 at 05:37:38PM -0700, Mark A. Greer wrote:
> > From: Mark A. Greer <mgreer@mvista.com>
> > 
> > Convert the prpmc2800.dts file to dts-v1.  Basically, this means
> > converting the numeric constants to be 'C'-like (e.g., hexadecimal
> > numbers start with '0x').
> 
> [snip]
> >  				interrupt-parent = <&/mv64x60/pic>;
> 
> If you're converting to dts-v1, you should also convert any path
> references like this to &{/mv64x60/pic} or else use a label.  Yes,
> some early dts-v1 supporting dtc versions supported these as is, but
> the idea is to try to forget that they existed and always require the
> {} quoting in dts-v1.

I did convert to use labels in a later patch but it uses <&label> as
well.  I can change them to &{label} that it appears you are suggesting
(I haven't tested to see that they work yet though).

Mark
