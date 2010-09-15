Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:43:39 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Stefan Roese <sr@denx.de>
Subject: Re: Question on of_address_to_resource() with offset != 0
Message-ID: <20100915184339.GB4446@angua.secretlab.ca>
References: <201009141629.06825.stefan.roese@gmail.com>
	<201009151459.43087.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201009151459.43087.sr@denx.de>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 02:59:42PM +0200, Stefan Roese wrote:
> On Tuesday 14 September 2010 16:29:06 Stefan Roese wrote:
> > I'm stumbling upon a problem noticed on the Ebony (440GP) eval board.
> > Here the first chip-select is connected to 512KiB of SRAM and 512KiB
> > NOR flash.
> 
> "Brown paper bag" time for me. Problem was located in U-Boot. Sorry for the 
> noise.

:-)

g.
