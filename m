Message-ID: <E380A44D523BD5118EAE0002A52CE5C40B87CB13@zcard0k8.ca.nortel.com>
From: "Andrew Williams" <awilliam@nortelnetworks.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: FW: Code Clean-Up
Date: Mon, 26 Apr 2004 17:48:10 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


No I have no specific code segment in mind.
(perhaps kernel/time.c?)

I was actually looking forward to 8260 vs 8270
which have very similar immaps. Do we want to clutter
the 8260_immap with conditional compiles specific to the
8280 series (70/75/80), or create a new immap_8270.h.

I'm just curious as to what the "consensus" is surrounding
this type of change. No sense posting patches that don't
fit others views of the architecture.

Andrew


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
