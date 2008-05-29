Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove some small bashisms from test scripts 
In-reply-to: <20080529061621.GA7220@yookeroo.seuss> 
References: <20080529061621.GA7220@yookeroo.seuss>
Date: Thu, 29 May 2008 08:19:46 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1K1i2k-0006Cc-EC@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Some of the helper scripts used to run testcases contain some
> constructs that are bashisms.  Or at least which don't work on dash,
> the minimal shell used as /bin/sh on recent Ubuntu systems.
> 
> This patch removes these constructs so that the testsuite will pass
> "out of the box" on systems where /bin/sh is dash.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
