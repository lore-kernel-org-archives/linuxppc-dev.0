Date: Sat, 10 Mar 2001 17:53:58 +0000
Subject: UPDATE dmasound to 2.4.3p3
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: paulus@linuxcare.com.au, haworth@ncal.verio.com
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010310175406.BD7E02EFE3@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi all,

I've updated the dmasound (_all) patch to 2.4.3p3.

The only real change is in the way the Makefile is done (this patch should
also apply cleanly to Paulus rsync tree - but I didn't test that yet ;-)

I have another 4 changes in the pipeline - but this will keep anyone who's
using them from having to mess with merging.

against 2.4.3.p3 BK as of 16:00 GMT/UTC today.

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3p3-dmasound/dmasnd-2.4
.3p3_all.diff.bz2

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
