Message-ID: <388CAB81.E33EC994@grn.georet.net>
Date: Mon, 24 Jan 2000 14:44:01 -0500
From: Ryan Boder <rboder@grn.georet.net>
Reply-To: rboder@grn.georet.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Rev 14 feedback
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got the current rsync tree by doing a
rsync -arvz linuxcare.com.au:: linux-pmac-stable

Then I went to apply the rev 14 patches from Ben's test page, but only a
few of them worked. Most of them said patch reversed or patch already
applied. Whatever the case they didn't apply cleanly.

Then when compiling the kernel I got lots of warnings and 2 errors in
/usr/src/linux/arch/ppc/kernel/prom.c so I removed it and replaced with
with that file from the last stable tree I had. This let the kernel
compile and it booted but i still don't have network access.

I know the rsync tree was current because I just got it today (1/24/00).
I had this problem once before when i was using the wrong source tree
with the patches. am I screwing up or is there something wrong with the
patches?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
