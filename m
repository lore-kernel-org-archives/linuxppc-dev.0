Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Moving from U-Boot to Linux
Date: Thu, 6 Mar 2003 12:20:29 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNKEKACIAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <OFE29A8037.C2791FC8-ONC1256CE1.005A66EB-C1256CE1.005B5CE7@se.wavetek.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

We have successfuly brought up u-boot on our custom ppc 405GPr board.

Now the next step for us is to get Linux up and running on the board.

We used the Walnut configurations as a starting point to get u-boot up
and running - we had to vary from the Walnut board code and configuration
to get all the interfaces on our board to work.  For instance we had to
change the pci configuration, as well as the bank configurations.

My question is, given the fact that we went through the process of
discovering the differences between code for our board, and the Walnut
board, and assuming we start with a kernel that is configured for the
Walnut board, will we have to make the same changes in the kernel as
we did in u-boot.  It seems that since u-boot does all of our
initialization,
that the kernel need no do this again.

Jerry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
