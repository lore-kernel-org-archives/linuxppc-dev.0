Message-ID: <3B9CFDFF.2A3D02AE@mvista.com>
Date: Mon, 10 Sep 2001 10:53:03 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org, Dan Malek <dan@mvista.com>
Subject: Re: [PATCH] some fixups for ppc405_enet init code
References: <20010907201341.A1856@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> This change is for Config.in and the Makefile to add the
> ppc405_enet driver.
>
> I also removed the _probe1 function and moved the code down
> into the init function. This was done for 2 reasons: 1 the
> dev->name is not know until the device is registered and
> 2 so the code would be removed after init.
>
> I also added a kfree of the private data when the register
> fails and when the module is removed.
>
>   ------------------------------------------------------------------------
>
>    ppc_enet.diffName: ppc_enet.diff
>                 Type: Plain Text (text/plain)


 Thanks, I'll make the appropriate changes.

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
