Return-Path: <jbarnes@virtuousgeek.org>
Received: from oproxy8-pub.bluehost.com (oproxy8.bluehost.com
 [IPv6:2605:dc00:100:2::a8])
 by ozlabs.org (Postfix) with SMTP id C9B06B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2012 05:28:55 +1100 (EST)
Date: Fri, 9 Mar 2012 10:28:46 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: 3.3.0-rc6-next-20120308 boot failure on POWER7 blade
Message-ID: <20120309102846.51f0df89@jbarnes-x220>
In-Reply-To: <20120309144645.5b5997d2@kryten>
References: <20120309142555.7ec5e0ac@kryten> <1331263785.3105.52.camel@pasglop>
 <20120309144645.5b5997d2@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@ozlabs.org, yinghai@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 9 Mar 2012 14:46:45 +1100
Anton Blanchard <anton@samba.org> wrote:

> 
> Hi Ben,
> 
> > Looks like something that got fixed but the new patches from Bjorn
> > aren't in next yet. I'll fwd you the patch separately to apply on
> > top of what you have see if that helps (to confirm that's indeed the
> > issue).
> 
> Thanks, confirmed that it fixes it. Patch below in case anyone else is
> hitting it.
> 
> Anton
> 
> --
> 
> On Sat, 2012-03-03 at 08:52 +1100, Benjamin Herrenschmidt wrote:
> 
> > Or give me a chance to dig :-) I'll have a look next week.
> 
> This is indeed what bjorn suspected on irc, this patch fixes it:
> 
> (Bjorn, please fold it in the original offending patch)

Thanks guys; I'll push the fixes to -next when I get to a real network
(at the airport now about to run out of battery with a crappy
connection).

Jesse
