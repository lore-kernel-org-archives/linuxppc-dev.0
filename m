Return-Path: <jmtd@debian.org>
Received: from bryant.redmars.org (unknown
 [IPv6:2a01:7e00::f03c:91ff:fedf:9c5f])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3D7292C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 20:12:57 +1000 (EST)
Date: Wed, 26 Sep 2012 10:27:55 +0100
From: Jon Dowland <jmtd@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: enabling suspend-to-ram for a headless powerpc g4 mac mini
Message-ID: <20120926092755.GA7022@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

I'm aware that suspend to ram is not enabled for g4 mac minis, due to
lack of support for waking up the video chipset¹.

I use a headless mac mini as a NAS device and so working video is not
important to me.  That prior thread on the topic gives me enough of a
clue to enable support but not to give up attempting to restore the
video.

Can anyone give me some hints/pointers on how to configure or hack the
kernel so that video is simply ignored?

Thank you very much for any help.

¹ https://lists.ozlabs.org/pipermail/linuxppc-dev/2011-January/088159.html
