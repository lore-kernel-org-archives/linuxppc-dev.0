Message-ID: <39E855BE.2D8AB848@dynamite.com.au>
Date: Sat, 14 Oct 2000 12:46:54 +0000
From: Brad Hards <bradh@dynamite.com.au>
MIME-Version: 1.0
To: Michel Dänzer <daenzerm@student.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: bk_2_3: USB mouse weirdness
References: <39E73C23.650F6BE2@student.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
> However, there is one oddity: When I quit my GNOME session, the USB mouse
> doesn't work anymore. The same if I switch from X to console. Un- and
> replugging the mouse resurrects it. The trackpad works fine all the time, also
> via the input layer.

This is not a PPC problem, it is a USB problem - I've also seen it on my
i386 scratch box.

Gunther Mayer posted a patch for this problem on the linux-usb-devel
mailing list, see:
http://www.geocrawler.com/lists/3/SourceForge/2571/25/4487408/

I haven't tried the fix yet, YMMV.

Brad

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
