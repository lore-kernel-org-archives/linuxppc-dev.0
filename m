Message-ID: <3BC488CA.E4F176D6@mvista.com>
Date: Wed, 10 Oct 2001 10:43:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Sarnath K - CTD, Chennai." <k_sarnath@ctd.hcltech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to boot linux on sandpoint board ?
References: <EF836A380096D511AD9000B0D021B5271A87B1@narmada.ctd.hcltech.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath,

Yes, the sandpoint is supported in the public linux source base.  There are
some things you need to know, though.

1) There are 2 types of sandpoint boards, X2 and X3, you have to know which
one you have and select the appropriate option
2) It has been some time since I've verified that it still works and a lot has
changed (in linuxppc_2_4_devel) so you may run into problems
3) Depending on how you download, etc., you may need to strip off the first
64KB of the zImage
4) The general instructions for building a kernel are:
  a) get the src (I'm assuming linuxppc_2_4_devel) and [cross]compile tools
  b) go into the top level directory (and set the Makefile appropriately)
  c) "make sandpoint_config"
  d) "make oldconfig" (or menuconfig if you need to change some options)
  e) "make dep zImage"
  f) the zImage (which is probably what you want) will be in
arch/ppc/boot/images/zImage.sandpoint

For more info, you need to refer to the mailing list archives and appropriate
linuxppc websites.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
