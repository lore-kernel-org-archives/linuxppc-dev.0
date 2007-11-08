Return-Path: <olof@lixom.net>
Date: Thu, 8 Nov 2007 09:28:21 -0600
From: Olof Johansson <olof@lixom.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: mpc5200, sysctl table check failed
Message-ID: <20071108152821.GA24851@lixom.net>
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
	<20071107204138.GA7066@lixom.net>
	<1194534579.6294.46.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1194534579.6294.46.camel@johannes.berg>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 08, 2007 at 04:09:39PM +0100, Johannes Berg wrote:
> 
> 
> > I posted a patch for this yesterday, it's harmless, just a warning.
> 
> That's not actually true, if the sysctl check code warns in any way the
> sysctl file doesn't show up in /proc/sys/

Oh, you're right. Well, it's been fixed now anyway. :-)


-Olof
