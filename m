Message-Id: <20010403010620.Postino-017265@smtp01.highway.ne.jp>
Date: Tue, 3 Apr 2001 01:06:20 +0900
To: Denis <denis.muquardt@chello.be>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: 3dfx kernel patch
In-Reply-To: <v04220800b6ee4b75dab2@[213.132.135.63]>
References: <v04220800b6ee4b75dab2@[213.132.135.63]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Denis <denis.muquardt@chello.be>
To: linuxppc-dev@lists.linuxppc.org
Subject: 3dfx kernel patch
Date: Mon, 2 Apr 2001 17:39:31 +0200

>
> Hello,
> my computer is a beige G3 with a 3dfx 3 2000 card. I cannot boot
> correctly on my 3dfx. I have recompiled the kernel 2.4.3 but the text
> seems to be mirrored (the top of the character is at the bottom and
> vice-versa) and  the color of the console are not correct.  My kernel
> arguments are video=tdfx:1024x768-8@60, but I have tried a lot of
> configurations.
>
> Is there a patch for the kernel 2.4.x ???

>video=tdfx:

The name is worng,It's tdfxfb.
But I don't have the card.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
