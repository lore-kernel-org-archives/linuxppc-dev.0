Message-ID: <3EE0C9CC.1581ECC5@dualg4.com>
Date: Fri, 06 Jun 2003 10:05:17 -0700
From: Jim Potter <jpotter@dualg4.com>
Reply-To: jpotter@dualg4.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE Partition check overwrites vectors
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm implementing the IDE driver on my embedded system, and I've got a
strange problem -- when it performs the Partition check, it overwrites
the vector area (when in read_cache_page()).  Obviously, some caching
variable hasn't been setup, so it's writing to addr zero;  I'm not a mm
person, anyone have any suggestions on this?  Many thanks.

The system is Linux version 2.4.21-rc6, pulled from linuxppc_2_4_devel
several days ago, with a custom platform entry adapted from ev64260.c.

--
Sincerely,

Jim Potter
45th Parallel Processing, Inc.

  Volunteer Firefighting: Bustin' ours, Savin' yours.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
