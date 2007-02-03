Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Sat, 3 Feb 2007 08:40:05 +0100
References: <45BE4ED0.5030808@us.ibm.com> <200701310752.48632.arnd@arndb.de>
	<45C36B21.60400@us.ibm.com>
In-Reply-To: <45C36B21.60400@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702030840.06270.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 02 February 2007 17:47, Maynard Johnson wrote:
> 
> > We also want to be able to profile the context switch code itself, which
> > means that we also need one event buffer associated with the kernel to
> > collect events that for a zero context_id.
> The hardware design precludes tracing both SPU and PPU simultaneously.
> 
I mean the SPU-side part of the context switch code, which you can find
in arch/powerpc/platforms/cell/spufs/spu_{save,restore}*.

This code is the one that runs when context_id == 0 is passed to the
callback.

	Arnd <><
