Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
Date: Fri, 25 Jul 2008 11:11:26 +1000
References: <1216887460.306306.238738123378.1.gpush@pingu>
	<200807250108.m6P18f4B099179@sullivan.realtime.net>
In-Reply-To: <200807250108.m6P18f4B099179@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200807251111.26673.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton,

> Yes.  How about all dtbImage, zImage, cuboot, treeboot, etc
> that are newer than vmlinux?

The existing arch code doesn't do any checks for timestamps, perhaps 
this would be better implemented as an arch-independent change?

(but would you like me to add treeboot and cuboot?)

Cheers,


Jeremy
