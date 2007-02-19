Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Litke <agl@us.ibm.com>
In-Reply-To: <1171917307.22940.35.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<1171911281.22940.21.camel@localhost.localdomain>
	<1171914050.18571.35.camel@localhost.localdomain>
	<1171917307.22940.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 07:47:25 +1100
Message-Id: <1171918045.18571.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-19 at 14:35 -0600, Adam Litke wrote:
> On Tue, 2007-02-20 at 06:40 +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-02-19 at 12:54 -0600, Adam Litke wrote:
> > > Patch seems good to me.  I tried it on my power4+ system and it was not
> > > happy.  Have you tested on Power4 at all? 
> > 
> > No, on Power5 only so far, I might still have something wrong :-) What
> > did you try and what was not happy ?
> 
> I haven't investigated too deeply yet, but it didn't boot.  Seemed
> unable to find init.  [ And yes, I am sure it's not something related to
> missing scsi drivers ;) ] Anything you want me to try out?  

You can try #define'ing DEBUG in slice.c and booting with "debug" on the
kernel command line ?

Ben.
