Message-ID: <3BAAC3CB.AEE1AE8D@mvista.com>
Date: Fri, 21 Sep 2001 00:36:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH]ppc_ksyms needs consistent_ funcs
References: <20010920210836.C19199@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> I don't know if these need to be conditional or not but I need
> them exported to work on a PCI driver.

I think they need to be wrapped with CONFIG_NOT_COHERENT_CACHE,
I'll check.  Sorry I missed them.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
