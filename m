Date: Thu, 3 Jul 2003 10:32:40 -0600 (MDT)
From: daRonin <daronin@digimerc.com>
To: Jim Baughman <jbaughmn@arlut.utexas.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 17" Apple laptops supported?
In-Reply-To: <3F039495.4010207@arlut.utexas.edu>
Message-ID: <Pine.LNX.4.56.0307031028570.1608@daronin.digimerc.com>
References: <3F039495.4010207@arlut.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Jul 2003, Jim Baughman wrote:

>
> Are Apple's 17" laptops supported in current 2.4 or 2.5 kernels?  If so,
> are there any iso's available for installation?

  It's not a question of kernel. 2.4.20 runs fine on the hardware. However
you are rather restricted because of closed chipset. First you have Nvidia
video card in it. The basic support for it is there in the kernel and
Xfree, however you can forget about DRI and even about having 24bit
colors.

  And then you have Airport Extreme, which is a closed chipset as well,
and doesn't work in Linux at all.

  daRonin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
