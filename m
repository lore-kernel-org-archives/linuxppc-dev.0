Date: Mon, 22 Apr 2002 14:16:01 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Status on 405GP i2c driver
Message-ID: <20020422141601.B16319@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It looks like this question was lasted asked around Jan/Feb, but
I have not seen an update on the status recently.

I have looked at the i2c-2.6.3 and I am reluctant to spend any
time working on it since it needs to go through some formating
changes to get rid of the C++ style comments. I don't want to
deal with a merge issues of doing a style change unless I know
it will go in.

I am also more inclined to use the actual transfer function
I have worked with in the PPCBoot rather than the functions
in the linux i2c code.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
