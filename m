Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18509.7013.755926.968038@cargo.ozlabs.ibm.com>
Date: Mon, 9 Jun 2008 22:00:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Changing from "[POWERPC]" to "powerpc:" in git headlines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Upon prodding from Andrew Morton, and after discussing it with a few
people, I have decided to change the way we format the git headline
(the first line of the commit text) for powerpc-related patches.
Instead of starting the headline with "[POWERPC]" or "[POWERPC]:
subsystem", we're now going to use "powerpc:" or
"powerpc/subsystem:".  This is in line with what many other subsystems
are doing these days and it conforms with the principle that square
brackets in patch subjects are used to delimit information which
shouldn't go into the permanent record (e.g., [1/7] or [RESEND]).

I'm making this change from now on for commits that are queued up for
2.6.27.  For 2.6.26 I'm going to stick with the old convention.

So if people are sending patches for 2.6.27, it would be helpful if
you put "powerpc:" or "powerpc/subsystem:" at the start of the patch
subject.  People who are putting commits destined for 2.6.27 or later
into a git tree for me to pull need to make sure they format the
commits this way.  (It's more important to get it right in the git
tree case because I can edit patches but not git commits.)

Paul.
