Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 01:49:54 +0200
References: <20060429232812.825714000@localhost.localdomain>
	<445690F7.5050605@am.sony.com>
	<FE7E70B5-F0CD-4254-8555-27EC2A70C316@kernel.crashing.org>
In-Reply-To: <FE7E70B5-F0CD-4254-8555-27EC2A70C316@kernel.crashing.org>
MIME-Version: 1.0
Message-Id: <200605020149.55310.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 May 2006 01:09, Segher Boessenkool wrote:
> So it really should be
> 
>         depends on PPC_CELL_NATIVE
> 
> or similar.  Having PPC_CELL mean "native" / "raw" is not the
> way to go, there will be many many hypervisors in the future,
> it would be nice to have PPC_CELL mean just that, "support for
> the Cell architecture" in general, kernels running on various
> hypervisors will see the hardware virtualised to varying degrees.
> 
Yes, good point.

	Arnd <><
