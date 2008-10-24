Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: GPIO - marking individual pins (not) available in device tree
Date: Fri, 24 Oct 2008 15:20:18 -0700
In-Reply-To: <49024646.3050300@genesi-usa.com>
References: <4900ED81.3040202@genesi-usa.com>
	<4900F90B.80703@firmworks.com><4901032F.3090805@genesi-usa.com>
	<49011C42.2020101@firmworks.com> <49024646.3050300@genesi-usa.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Matt Sealey" <matt@genesi-usa.com>,
	"Mitch Bradley" <wmb@firmworks.com>
Message-ID: <20081024222059.1835015F004D@mail181-va3.bigfish.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> One thing I had a crazy dream about was a GUI-based device tree
builder
> for platforms. Instead of editing them manually and passing them
> through the compiler, wouldn't it be fun to drag and drop system
> components (and build new ones) into something like a DirectX Filter
> Graph Builder (or the GStreamer one for that matter) or those GUI
> SQL database builders, so that you could build a tree and have it
> output all the craziness and connect phandles to range properties
> etc.
> =

> That way dropping a bunch of pins on a GPIO bank, or i2c devices
> on an i2c bus (I have a board here with an i2c bus with 8 devices
> on it, I suppose you could have more than 100 if you got your
> addresses right) and having a device tree that goes on for 8
> screens would not be so bad to maintain.
> =

> And no, I did NOT just volunteer to write one, I'm happy coding my
> device tree updates in Forth :)
> =

> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations

Why is this crazy?  This is essentially what we do today with PowerPC
and Microblaze processors in Xilinx FPGAs.  Even for ASIC SOCs, there
are several commercial 'connect-your-IP on the bus' tools that could (if
SOC providers thought it was important) generate the 'canonical' device
tree automagically.

I think the real question is: if part of the device tree describes
'hardware' (either in the SOC or on the board that, more or less,
doesn't change) and part represents 'hardware configuration' (e.g. My
board has my one-off hardware hanging off the gpio bank connected to the
40 pin header), then how do we separate the two so that the hardware can
be in a canonical form separate from the configuration.  Or perhaps
there are even three device tree fragments: one provided by an SOC
provider, one by a board provider, and one by the user, which can all be
nicely separated once the great device tree update happens... :)

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
