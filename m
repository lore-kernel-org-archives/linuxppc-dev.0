Return-Path: <dan@embeddededge.com>
In-Reply-To: <20050406223751.E4297C108D@atlas.denx.de>
References: <20050406223751.E4297C108D@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e27030866ac1c1efda319294eba6b626@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 6 Apr 2005 19:33:18 -0400
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel SCM saga..
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2005, at 6:37 PM, Wolfgang Denk wrote:

> are there any plans yet how to continue PPC  kernel  development  now
> that Linus (and probably others, too) stopped using BitKeeper?

For all practical purposes, we have stopped using it as intended long
ago.   When we first started, those of us responsible for maintaining 
part
of the sources simply continuously pushed updates.  Very efficient, 
everyone
saw what was up to date.  Since 2.4, we have all been passing patches
around,  pushing things into BK didn't seem to matter, and usually
were ignored or lost.  People responsible for certain areas of 
maintenance
are now just bypassed with sometimes bad patches just given to Andrew
directly.  We may as well go back to using CVS and passing patches
around, since it easier to do that than the way we have been using BK.

Thanks.

	-- Dan
