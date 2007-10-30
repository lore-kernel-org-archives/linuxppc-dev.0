Return-Path: <jdl@jdl.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: libfdt as its own repo and submodule of dtc? 
In-Reply-To: Your message of "Tue, 30 Oct 2007 10:23:25 CDT."
	<C98039BC-92DE-4398-B198-EDAD12A3670C@kernel.crashing.org>
References: <C98039BC-92DE-4398-B198-EDAD12A3670C@kernel.crashing.org> 
Date: Tue, 30 Oct 2007 10:56:30 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1ImtSB-0003vC-0j@jdl.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Jerry Van Baren <gerald.vanbaren@ge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> Jon,
> 
> It seems like have libfdt as a unique git repo that is a submodule of  
> the things that need it (dtc, u-boot, etc.) might make some sense and  
> it easier for the projects that need to pull it in.
> 
> Is this something you can take a look at? (or have other ideas on).

I would be fine with making libfdt a git repository separate
from the DTC repository if that makes it easier to integrate
it with other projects.

jdl
