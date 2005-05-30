Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050530061737.GB28195@suse.de>
References: <1117429620.5228.38.camel@gaston> <20050530061737.GB28195@suse.de>
Content-Type: text/plain
Date: Mon, 30 May 2005 16:22:11 +1000
Message-Id: <1117434132.5228.40.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: symlinks in /proc/device-tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-30 at 08:17 +0200, Olaf Hering wrote:
>  On Mon, May 30, Benjamin Herrenschmidt wrote:
> 
> > Hi !
> > 
> > Is anybody actually using one of these things in /proc/device-tree ?
> 
> Just make sure the devspec file in sysfs doesnt contain symlinks.

It doesn't.

Ben.
