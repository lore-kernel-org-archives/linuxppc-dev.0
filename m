Date: Fri, 30 Nov 2001 17:31:05 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC cross-compiling 1394 libraries
Message-Id: <20011130173105.21a0ec2b.iweiny@acm.org>
In-Reply-To: <3C082FD5.D1F6C997@carts.com>
References: <3C082FD5.D1F6C997@carts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 30 Nov 2001 17:18:13 -0800
Kevin Fry <kevin@carts.com> wrote:

>
> I need to compile some 1394 libraries for my embedded 8260 board running
> HHL 2.0. These
> are the libraw1394 libraries needed for Firewire.  They have a
> ./configure script
> and everything, but if I tell the script --target=powerpc-linux I get
> 100's of
> make errors.  I'm using the HHL2.0 cross compiler, maybe that needs
> something
> extra to be done?
>
> Any advice on cross compiling libraries would be very appreciated?
>

Whenever I have cross compiled something I have always just edited the
makefiles by hand.  If you are using a std Linux box then all the data types
should be ok and configure will pick things up just fine.

I don't remember but I think I compiled libraw at some point.  What are the
errors you are getting?  Now that I think about it you may want to make sure
you have it pointing to the kernel source you will be using on the walnut.
This is one area you must make sure things are the same.

Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
