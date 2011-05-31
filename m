Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110531131737.GA29164@doriath.ww600.siemens.net>
References: <20110531131737.GA29164@doriath.ww600.siemens.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 31 May 2011 13:12:18 -0600
Message-ID: <BANLkTi=k+mPXDmNJK=EVK23X9=rBoTedRg@mail.gmail.com>
Subject: Re: PCI EDAC on MPC85xx
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2011 at 7:17 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> Long time ago (around July of 2010), I've reported a problem of binding
> pci error reporting driver to the hardware (See
> http://thread.gmane.org/gmane.linux.kernel.edac/181). Grant Likely has
> come with a patch to create platform devices (of_platform at that time),
> for device_nodes which have "compatible" properties
> (http://article.gmane.org/gmane.linux.ports.ppc.embedded/36981).
>
> The patch was not applied at that time and the problem still arises at
> 3.0-rc1. Should the patch in question be applied, or is there any new
> solution?
> Current version of that patch which I have in my tree is attached
> to this mail (no original signoff by Grant).

Hi Dmitry,

I've since looked at the problem more, and I've been working on
refactoring both of_platform_bus_probe(), and creating a new function,
of_platform_populate(), which implements the symantics that I think
are needed for your use case.  The work isn't done yet, but it has
gone out for at least one round of review, and I hope to get it into
the 3.1 merge window.

g.
