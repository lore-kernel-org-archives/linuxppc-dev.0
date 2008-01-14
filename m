Return-Path: <olof@lixom.net>
Date: Sun, 13 Jan 2008 22:42:16 -0600
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: I2C and CAN bus on MPC5200B device tree
Message-ID: <20080114044216.GA23349@lixom.net>
References: <478A967E.7080201@genesi-usa.com>
	<fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 13, 2008 at 05:35:09PM -0700, Grant Likely wrote:
> On 1/13/08, Matt Sealey <matt@genesi-usa.com> wrote:
> >
> > Hi guys,
> >
> > I know the I2C stuff is up in the air (I cannot pinpoint the documentation
> > for it) and have not found any CAN bus documentation for device trees.
> >
> > I want to update the firmware tree to add these but, am basically looking
> > for those docs, or someone to go over a few points.. is there some kind of
> > tree standard I should be looking at, or some patch I missed which has
> > a driver which implements something that looks at a compatible tree?
> 
> I think some consensus has been achieved for describing i2c busses and
> their attached devices, but I don't think booting-without-of.txt has
> been updated with the details yet.  I need to look into that more.

I think simple devices might have been agreed upon (but it's been a
while since it was covered). Muxed busses probably hasn't. Either that
or I completely missed the emails.


-Olof
