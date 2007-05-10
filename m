Return-Path: <dgibson@ozlabs.org>
Date: Fri, 11 May 2007 08:40:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: arch/powerpc/sysdev: dumping ground or only for shared drivers?
Message-ID: <20070510224000.GA24329@localhost.localdomain>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510215730.GA25075@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510215730.GA25075@lixom.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 04:57:30PM -0500, Olof Johansson wrote:
> On Thu, May 10, 2007 at 01:02:37PM -0700, Mark A. Greer wrote:
> > This is the latest and hopefully last round of patches for adding mv64x60
> > and prpmc2800 support to arch/powerpc.  It would be great if this could
> > still get into 2.6.22.
> 
> I know Mark wants this merged, and I'm not looking to hold that off,
> however the following came up on IRC and I wanted to move it over here
> for clarification/list archiving of the answers:
> 
> 
> This adds yet another set of chipset drivers under sysdev, that are
> only used by one platform (several board ports under that platform,
> but only one platforms/* directory).
> 
> In my opinion, they really should go under the platform directory instead,
> and not clutter the shared directory.

I concur.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
