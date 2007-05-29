Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 0D5BADDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:31:22 +1000 (EST)
Date: Tue, 29 May 2007 06:32:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Refuse to build 64-bit with GCC-4.2.0 and
	CONFIG_MODULES
Message-ID: <20070529043220.GA2172@uranus.ravnborg.org>
References: <f7ff5aadda1b2962d6c45123ff944e9af6879306.1179593209.git.segher@kernel.crashing.org>
	<bd3cddd2f3192e3aba4d7c886e38d8d0037c3510.1179593209.git.segher@kernel.crashing.org>
	<20070528202822.GA31605@uranus.ravnborg.org>
	<91f430e6615a8895ec0d5293c21f618e@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91f430e6615a8895ec0d5293c21f618e@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 12:13:50AM +0200, Segher Boessenkool wrote:
> >>...since this won't work (compiler bug, see 
> >><http://gcc.gnu.org/PR31490>).
> >
> >Applied both and documented cc-fullversion too.
> 
> Thanks!  For reference, where should I have documented this?
Documentation/kbuild/makefiles.txt

	Sam
