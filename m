Return-Path: <glikely@secretlab.ca>
Date: Tue, 1 Jul 2008 10:43:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
Message-ID: <20080701164329.GF6918@secretlab.ca>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 01, 2008 at 11:12:58AM -0400, Jon Smirl wrote:
> On 7/1/08, Jean Delvare <khali@linux-fr.org> wrote:
> > I'm fine with this patch. In particular, exporting i2c_bus_type is OK.
> >  It was un-exported only because it had no user left, but it can be
> >  exported again if needed.
> 
> Another solution would be to move drivers/of/of_i2c into the i2c
> directory and make it part of i2c core on powerpc builds.

My preference is for things like of_spi and of_i2c to go with the
related busses; I think it makes more sense to keep all the I2C stuff
together, but I've already lost that battle once.

g.
