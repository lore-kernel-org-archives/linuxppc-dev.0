From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15743.64401.154459.318050@argo.ozlabs.ibm.com>
Date: Thu, 12 Sep 2002 12:27:29 +1000 (EST)
To: linuxppc-embedded@lists.linuxppc.org
Cc: trini@kernel.crashing.org
Subject: state of 4xx code in 2.5.x
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am becoming increasingly concerned about the quality, or lack of it,
of the 4xx code generally.  I think we need someone who has a good
amount of experience in Linux kernel coding to go through all the 4xx
code and clean it up and simplify it where possible.  I know that the
4xx family have quirks (e.g. DCRs) which make it difficult in places
to do things simply, but with a bit of creativity we can make the code
clearer and simpler than it is at the moment.

I should note that I mostly care about cleaning up the 4xx support in
2.5.x.  I don't want to make any major changes in linuxppc_2_4_devel
at this stage.

At the moment it seems that Tom Rini is the maintainer and Armin
Kuster and David Gibson are both working in the area, particularly on
the OCP support.  It seems though that Tom's life is very busy at the
moment with various things.  So I am proposing that I will take over
the 4xx maintainership for 2.5.x, at least for now, unless someone
else with a reasonable amount of kernel hacking cred steps forward and
volunteers to do it instead.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
