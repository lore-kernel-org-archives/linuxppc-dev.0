Return-Path: <khali@linux-fr.org>
Date: Tue, 1 Jul 2008 18:29:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
Message-ID: <20080701182949.12119d6e@hyperion.delvare>
In-Reply-To: <9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Jul 2008 11:12:58 -0400, Jon Smirl wrote:
> On 7/1/08, Jean Delvare <khali@linux-fr.org> wrote:
> > I'm fine with this patch. In particular, exporting i2c_bus_type is OK.
> >  It was un-exported only because it had no user left, but it can be
> >  exported again if needed.
> 
> Another solution would be to move drivers/of/of_i2c into the i2c
> directory and make it part of i2c core on powerpc builds.

I don't think this is a good idea. Merging arch-specific code (or
half-arch-specific code in this case) into arch-neutral drivers ends up
being a pain to maintain. People will keep sending me patches for stuff
I don't know anything about and can't help with. Having of-specific
stuff in just one directory as is the case now sounds much better to
me. All it's missing is a MAINTAINERS entry.

-- 
Jean Delvare
