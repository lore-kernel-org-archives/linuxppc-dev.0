Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AEDDF71.28439605@mvista.com>
Date: Mon, 30 Apr 2001 17:56:01 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: Laura Dean <tralad@yahoo.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ramdisk for rpx-lite
References: <20010430130651.12703.qmail@web12404.mail.yahoo.com> <3AEDDE2D.849EEFFA@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin Fry wrote:
>
> I too am looking for a pre-setup ramdisk .  But I'm looking for the one
> mentioned that exists for Monta Vista. 2.4.0 kernel.

I don't know who would have mentioned such a thing, because I'm not
aware of one.  I just install a few of the RPMs, strip the libraries,
and copy the target directory to the ramdisk.  Minimally, you need to
install the filesystem, bash, C library, and probably termcap (for
bash).  I don't use busybox, but you can probably install that somehow
as well.

There will be lots more cooler tools available soon, but this is
the method I am using now.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
