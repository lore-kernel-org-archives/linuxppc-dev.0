Date: Tue, 21 May 2002 14:16:43 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Dan Kegel <dank@kegel.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: khttpd crash verified with vanilla linuxppc_2_4_devel
Message-ID: <20020521141643.D20012@ecam.san.rr.com>
References: <3CEAAEFF.3D274083@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CEAAEFF.3D274083@kegel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 01:33:03PM -0700, Dan Kegel wrote:
>
> I can crash khttpd at will on a totally vanilla
> linuxppc_2_4_devel kernel as of changeset 1.749
> using an open source load generator, with or without
> the patch that fixes a khttpd crash on x86
> ( http://www.kegel.com/linux/khttpd/khttpd-unbork.patch ).
>
> This crash is not present on the imac with current kernels, nor
> in Hard Hat 2.0 on this same board, nor on the PC with current kernels.
> I believe it's a bug in the linuxppc_2_4_devel trunk.

What filesystem are you using? RAMfs? Can you try the imac using
the same FS?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
