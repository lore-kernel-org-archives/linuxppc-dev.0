Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4616BABC.9040802@am.sony.com>
Date: Fri, 06 Apr 2007 14:25:16 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Sync PS3 framebuffer on panic.
References: <1175208387.3122.82.camel@pmac.infradead.org>
In-Reply-To: <1175208387.3122.82.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> There's not a lot of point in printing a nice message about the panic
> unless we then ask the hypervisor to update the screen for us.

I added this one to ps3-linux.git.
