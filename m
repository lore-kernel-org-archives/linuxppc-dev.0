Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] ppc64: re-enable kexec to allow module loads with
	CONFIG_MODVERSIONS and CONFIG_RELOCATABLE turned on
Date: Fri, 4 Dec 2009 11:04:13 +1030
References: <20091119195216.GC11414@hmsreliant.think-freely.org>
	<20091203150417.GA17521@hmsreliant.think-freely.org>
In-Reply-To: <20091203150417.GA17521@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912041104.13408.rusty@rustcorp.com.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 4 Dec 2009 01:34:17 am Neil Horman wrote:
> Just finished testing your patch Rusty, it all works quite well, Thanks!
> Will this be going in via your tree, or the ppc tree?

It's in my tree now.  Since I didn't really alter the ppc parts, I kept
Paul's ack attached too.

Thanks,
Rusty.
