Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15973.18737.651334.824024@argo.ozlabs.ibm.com>
Date: Wed, 5 Mar 2003 11:47:45 +1100
To: "Dale Farnsworth" <dale@farnsworth.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
In-Reply-To: <20030305000708.GD4683@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org>
	<3E64FD53.3030107@embeddededge.com>
	<20030304201302.GA4683@rover.farnsworth.org>
	<3E650AAF.7060804@embeddededge.com>
	<20030304230849.GB4683@rover.farnsworth.org>
	<3E6534FA.9070503@embeddededge.com>
	<20030304234253.GB17093@ip68-0-152-218.tc.ph.cox.net>
	<20030305000708.GD4683@rover.farnsworth.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth writes:

> Since __secondary_hold writes to 0x4 and only reads 0x0 looking for
> it's cpu id, I still like the "b __start" at 0x0.

Why are we still using locations 0 and 4 if that is causing trouble?
Why not change to 0xf0 and 0xf4 or something else out of the way?  We
can do the change simultaneously in the boot wrapper and in head.S, so
there are no compatibility issues.

Just a suggestion. :)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
