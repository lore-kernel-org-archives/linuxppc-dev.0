Return-Path: <olof@lixom.net>
Date: Fri, 26 Aug 2005 14:04:03 -0500
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050826190403.GA6265@austin.ibm.com>
References: <20050823225303.GF31949@krispykreme>
	<0192F2FD-0132-4B51-9524-590084E3FB0B@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0192F2FD-0132-4B51-9524-590084E3FB0B@freescale.com>
From: Olof Johansson <olof@lixom.net>
Cc: Andrew Morton <akpm@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: Add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2005 at 02:00:43PM -0500, Kumar Gala wrote:
> Any reason we shouldn't do the same thing on ppc32?

When I built a 2.6.13-rc7 I got the question about what HZ I wanted,
so I guess we're already doing it. Maybe the default needs changing
though, can't remember what it was.


-Olof
