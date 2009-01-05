Return-Path: <scottwood@freescale.com>
Date: Mon, 5 Jan 2009 13:20:53 -0600
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <LeoLi@freescale.com>
Subject: Re: The usage of compatible 'simple-bus'
Message-ID: <20090105192053.GB23766@ld0162-tx32.am.freescale.net>
References: <3A45394FD742FA419B760BB8D398F9ED0B37E7@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED0B37E7@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 06:27:39PM +0800, Li Yang wrote:
> I got an assumption from the existing device trees that having
> 'simple-bus' in the compatible property of a node means that all child
> nodes should be added as of_platform_device in platform initialization
> phase.  No matter it represents a bus in common sense or not.  Is this
> truly the case? 

Yes, simple-bus indicates that the children can be driven standalone from
any knowledge of the parent bus.

> Shall we document this?

It is documented in ePAPR.

-Scott
