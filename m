Return-Path: <jdl@jdl.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH V2] DTC: Remove support for the legacy DTS source file
	format.
In-reply-to: <ed82fe3e0808150817k66d6c70fp17774fbd726ea2b2@mail.gmail.com> 
References: <E1KTlq7-0005Gh-Co@jdl.com> <20080815002936.GA9877@yookeroo.seuss>
	<ed82fe3e0808150817k66d6c70fp17774fbd726ea2b2@mail.gmail.com>
Date: Fri, 15 Aug 2008 10:44:33 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KU1Td-0006ub-8O@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, Aug 14, 2008 at 7:29 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> > On Thu, Aug 14, 2008 at 06:02:43PM -0500, Jon Loeliger wrote:
> >> Now that all in-kernel-tree DTS files are properly /dts-v1/,
> >> remove direct support for the older, un-numbered DTS
> >> source file format.
> >
> > Um.. why?  I just don't see a compelling reason to remove this
> > backwards compatibility.  It costs us very little to keep it around
> > indefinitely.

Because we are going to get rid of the cruft, simplify things,
and move forward.  Really.  This was the plan from the onset.

> I agree, why are we removing backwards compatibility?  The dts-v1
> format isn't that old, so I'm sure there are plenty of device trees
> out there, especially on our BSPs, that haven't been updated yet.

They can run the conversion tool and be fine.

> How about just printing a warning and saying that the device tree
> should be updated with the conversion tool?

How about all the in-tree DTS files are already V1?

jdl
