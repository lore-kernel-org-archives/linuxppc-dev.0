Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 98226B6F88
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2011 08:11:31 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 00/10] powerpc/mpic: General cleanup patch series
Date: Mon, 31 Oct 2011 17:10:01 -0400
Message-Id: <1320095411-20667-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I've been tinkering with a series of patches to clean up the PowerPC
MPIC/OpenPIC init recently as part of a new board port I'm working on.

It's reached the point where I'd like some feedback on the general
approach.  The code itself hasn't been tested at all yet, and probably
does not compile right now (though that is my next step).

(Oh, actually, the first patch isn't really even about the MPIC code,
it should probably be reviewed on its own; oh well...)

Please let me know what you think.

Cheers,
Kyle Moffett

--
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
