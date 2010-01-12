Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/31] hvc_console: make the ops pointer const.
Date: Tue, 12 Jan 2010 22:06:34 +1030
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1263262906.724.175.camel@pasglop>
In-Reply-To: <1263262906.724.175.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201001122206.34252.rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org,
	virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jan 2010 12:51:46 pm Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-22 at 20:04 +0530, Amit Shah wrote:
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > This is nicer for modern R/O protection.  And noone needs it non-const, so
> > constify the callers as well.
> 
> Rusty, do you want me to take these via powerpc ?

Sure, thanks.

Rusty.
