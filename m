Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 18A55B7B96
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 18:17:51 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC5121 CAN and USB
Date: Mon, 19 Oct 2009 08:46:51 +0200
References: <4AD5ADC9.30503@embedded-sol.com>
	<26b052040910151603y8fc9b00g678d6a873083f1e7@mail.gmail.com>
	<20091015231005.D2CE9F15432@gemini.denx.de>
In-Reply-To: <20091015231005.D2CE9F15432@gemini.denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200910190846.51906.david.jander@protonic.nl>
Cc: =?iso-8859-1?q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Gibson <paul.gibson2074@gmail.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 16 October 2009 01:10:05 am Wolfgang Denk wrote:
> Dear Paul,
> 
> In message <26b052040910151603y8fc9b00g678d6a873083f1e7@mail.gmail.com> you 
wrote:
> > > The "ltib-mpc5121ads-20090602" branch reflects the exact state of the
> > > kernel contained in the LTIB with this name (dated July 2009, despite
> > > the name; based at 2.6.24.6, i. e. 7+ kernel versions behind).
> >
> > I have diff'ed this and it is very similar to the ltib in the BSP.
> > The MBX patches may be missing though.  These patches can be obtained
> > via the Freescale SDK for the OpenGL on the MPC5121e webpage.
> 
> Who cares. This code is about 8 (!) kernel releases behind. Scrap
> it.

I would love to, but as it stands, this is still the best we can get for the 
MPC5121e :-(
I took that branch, merged the MBX patch in from the LTIB and ported the new 
NFC driver from the 'mpc512x' branch back to this one, since the original 
driver is buggy. 
The latest OpenGL-ES libraries and MBX drivers released are closed-source, 
buggy, but stable and seem to work well if your program doesn't do the kinds 
of things that make it crash. 
If you know the limitations of this and can live with it, it might be 
bearable... I don't have any other option :-(

Best regards,

-- 
David Jander
Protonic Holland.
