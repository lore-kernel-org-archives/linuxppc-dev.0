Return-Path: <b07421@freescale.com>
Date: Thu, 5 Apr 2007 11:34:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org, david@gibson.dropbear.id.au
Subject: Status of bootwrapper patches
Message-ID: <20070405163421.GA28275@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
What's the status of David's bootwrapper patches:
"Add device tree utility functions to zImage", and
"Clean up zImage handling of the command line"?

IIRC, Paul said on IRC a while back that David was planning on revising
them; is that likely to happen any time soon?  They're required for my
cuImage patches, which I'd like to get into 2.6.22 if possible.

If newer patches aren't going to happen soon, can we apply the existing
ones as a base for further development, and fix the issues with them
(what are they?) later?  Assuming they don't cause regressions, of
course.

Once those patches are in, I'll submit a revised cuImage patch that
handles cleanup properly (I'd been spoiled by git-clean and forgotten
about the other way :-P )

-Scott
