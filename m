Date: Wed, 25 Feb 2004 08:22:24 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Phil Thompson <philt@4bridgeworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440GX Support on Linux v2.4
Message-ID: <20040225162224.GC16573@gate.ebshome.net>
References: <C18BA5DDB58DD511BD0700C0DF0DD45028B27A@NTSERVER4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD45028B27A@NTSERVER4>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Feb 25, 2004 at 03:54:08PM -0000, Phil Thompson wrote:
>
> I need to bring up Linux 2.4 on an IBM 440GX evaluation board (Ocotea I
> assume). It is supported on Linux 2.6.
>
> What's my best option for doing this...
>
> Somebody already has a patch for 2.4? :)
>
> Backport the code from 2.6?
>
> Enable 440GP compatibility mode and hack the existing 2.4 Ebony board
> support?

There is an Ocotea support in linuxppc-2.4 tree already, you don't
need to hack, patch or backport anything.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
