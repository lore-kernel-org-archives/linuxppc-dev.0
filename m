Date: Tue, 25 Sep 2001 19:09:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtmsr...
Message-ID: <20010925190942.B13535@cpe-24-221-152-185.az.sprintbbd.net>
References: <35C119252057D511BB9F0003476BF8A208E5C2@freexc01.smartm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35C119252057D511BB9F0003476BF8A208E5C2@freexc01.smartm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 25, 2001 at 06:53:19PM -0700, Prasad, Siva wrote:
>

> My zImage hangs immediately after executing the 'mtmsr' instruction in the
> arch/ppc/boot/head.S file.
>
> li    r3, 0
> mtmsr r3
> isync
>
> This is in the very beginning of the zImage, where it uncompresses the
> actual image. Can some one help me out.

What machine? What kernel?  From where?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
