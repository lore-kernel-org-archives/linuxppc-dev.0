Return-Path: <bwarren@qstreams.com>
Subject: BDI-2000 Config file for MPC8349 eval board
From: Ben Warren <bwarren@qstreams.com>
To: Linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 14 Apr 2006 18:03:07 -0400
Message-Id: <1145052187.972.275.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Does anybody have a solid config file for the Freescale MPC8349EMDS eval
board?  I guess the MPC8349ADS would be fine too, since I've been told
they're the same thing.  I've been tweaking the file named
'mcp8349e.cfg' that shipped with the BDI, but it's a bit flaky with my
board.  In particular, sometimes it can't write to the Flash programming
workspace, maybe indicating that the DDR isn't properly set up, but
there have been other things too that are slowly eating at me.

thanks,
Ben
