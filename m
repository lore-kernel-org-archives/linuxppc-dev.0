Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 55F87B70AF
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 18:38:42 +1000 (EST)
Date: Mon, 16 Aug 2010 10:38:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc: fix typo in uImage target
Message-ID: <20100816083839.GA6851@merkur.ravnborg.org>
References: <1281947216-15342-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281947216-15342-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@ozlabs.org, stable <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 16, 2010 at 10:26:56AM +0200, Anatolij Gustschin wrote:
> Commit e32e78c5ee8aadef020fbaecbe6fb741ed9029fd
> (powerpc: fix build with make 3.82) introduced a
> typo in uImage target and broke building uImage:
> 
> make: *** No rule to make target `uImage'.  Stop.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: stable <stable@kernel.org>

blush...

	Sam
