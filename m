Return-Path: <benh@kernel.crashing.org>
Subject: Re: Ocotea board?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Mock <jeff@mock.com>
In-Reply-To: <471E39E0.5070106@mock.com>
References: <471E39E0.5070106@mock.com>
Content-Type: text/plain
Date: Wed, 24 Oct 2007 06:36:11 +1000
Message-Id: <1193171771.2085.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-23 at 11:13 -0700, Jeff Mock wrote:
> Is the Ocotea board (the original 440GX eval board) still interesting? 
> I'm wrapping up a project using the 440GX, I started out hacking on the 
> Ocotea board to get started, but we moved off Ocotea long ago onto our 
> own hardware.
> 
> I'm cleaning up the lab now that the project is nearly finished and I 
> would like to give the board to someone that will put it to good use. 
> I've sponged off this mailing list quite a lot, it's about time I give a 
> little something back.

Well, the ocotea has an interesting "feature" related to the way the
ethernet PHY an EMAC interact which I haven't dealt with in the new EMAC
driver at this stage.

I -think- the Taishan I have may have the same issue though, in which
case I won't need it, but if not, I could have good use (or Josh in
Rochester) for one of these.

> The board has been hacked a little bit but still works fine.  I just 
> powered it up and it happily booted Linux via TFTP.  The boot ROM now 
> has u-boot, the original PIBs (or whatever) is long gone. All I ask is 
> that you're self-sufficient and don't bug me too much about it...
> 
> Can someone recommend a good home?  Otherwise it will wind up in 
> storeroom purgatory.
> 
> jeff
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
