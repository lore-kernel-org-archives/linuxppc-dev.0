Date: Sun, 6 Feb 2000 07:48:01 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Error report : make clgenfb on 2.2.14
In-Reply-To: <389D8204.C51655F8@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10002060745010.16688-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	Last week I made a fix for this, you can grab the patch at
devel.linuxppc.org/users/ajoshi/fbcon-compat.patch.  this patch removes
the need for adding OFfb support by removing the xpmac compat code from
there and putting it in a new fbcon-compat.c file with some hooks from the
driver.

ani

On Sun, 6 Feb 2000, Martin Costabel wrote:
>
> Looks like you use CONFIG_FB_COMPAT_XPMAC=y and CONFIG_FB_OF off. Since
> these references are defined in drivers/video/offb.c, you will have to
> switch CONFIG_FB_OF on.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
