Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 380DEDDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 06:27:24 +1000 (EST)
Date: Mon, 28 May 2007 22:28:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Refuse to build 64-bit with GCC-4.2.0 and
	CONFIG_MODULES
Message-ID: <20070528202822.GA31605@uranus.ravnborg.org>
References: <f7ff5aadda1b2962d6c45123ff944e9af6879306.1179593209.git.segher@kernel.crashing.org>
	<bd3cddd2f3192e3aba4d7c886e38d8d0037c3510.1179593209.git.segher@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd3cddd2f3192e3aba4d7c886e38d8d0037c3510.1179593209.git.segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 19, 2007 at 06:49:08PM +0200, Segher Boessenkool wrote:
> ...since this won't work (compiler bug, see <http://gcc.gnu.org/PR31490>).

Applied both and documented cc-fullversion too.

	Sam
