Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3FDEF689AF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 19:06:03 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 5 Jan 2006 09:05:57 +0100
References: <1136414679.3463.10.camel@nighteyes.site>
In-Reply-To: <1136414679.3463.10.camel@nighteyes.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601050905.57377.david.jander@protonic.nl>
Subject: Re: powerpc vs ppc build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 04 January 2006 23:44, Jeff Angielski wrote:
> Is there a summary of the differences between the ppc and powerpc builds
> for the 2.6 kernels?  Or something describing what the community, in
> general, is trying to fix/address with the different schemes - besides
> the merging of ppc and ppc64?

Looks to me like ppc and ppc64 are deprecated and "phased out" in favour of 
powerpc. If you look at the contents of both the include/asm-ppc and 
include/asm-powerpc directories over the last revisions for example, you'll 
see files moving from asm-ppc to asm-powerpc. Now, they are in a kind of flux 
still, so you'll probably find yourself doing silly things like "ln -s 
include/asm-powerpc/* include/asm-ppc/" to keep things working and compiling
nicely.
I do hope this is over soon.

Greetings,

-- 
David Jander
