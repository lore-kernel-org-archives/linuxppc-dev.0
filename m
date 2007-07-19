Return-Path: <kim.phillips@freescale.com>
Date: Thu, 19 Jul 2007 17:28:06 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
Message-Id: <20070719172806.db53b792.kim.phillips@freescale.com>
In-Reply-To: <469FDB3B.5000901@freescale.com>
References: <20070719183415.7458.42622.stgit@trillian>
	<20070719183734.7458.83695.stgit@trillian>
	<469FB47D.4030009@freescale.com>
	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
	<20070719164036.f3d4c86d.kim.phillips@freescale.com>
	<469FDB3B.5000901@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Jul 2007 16:44:27 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Kim Phillips wrote:
> > the old FLAT_TREE u-boot fdt fixup code renames any existing chosen
> > node out of the way, and adds its fixed up version as /chosen.
> > 
> > The LIBFDT implementation replaces any existing /chosen with its fixed
> > up version.
> 
> Could you point out the code that does this?  I don't see it in either 
> the old code or the new.
> 

libfdt (new): do_fdt() calls fdt_chosen(..., force=1), where, in
fdt_chosen(), the check to not replace the existing node is governed by
the value of force.

[in gvb's fdt branch, where an 'fdt addr' command is no longer required
prior to bootm ing, do_bootm_linux() calls fdt_chosen(...,force=0),
so maybe it should be changed to force=1.]

about the old code, you're right, I don't see it either - I must have
been remembering running something else that did the rename.  Sorry for
the noise.

Kim



Kim
