From: linas@austin.ibm.com
Date: Fri, 2 Apr 2004 11:02:39 -0600
To: "Christopher R. Johnson" <cjohnson@gcctech.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: General question about caching
Message-ID: <20040402110239.A58706@forte.austin.ibm.com>
References: <406D92CF.8040302@gcctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406D92CF.8040302@gcctech.com>; from cjohnson@gcctech.com on Fri, Apr 02, 2004 at 11:20:31AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 02, 2004 at 11:20:31AM -0500, Christopher R. Johnson wrote:
>
> I have a tight footprint, and no swapping (in fact no disks).  I notice
> that /proc/meminfo reports:
...

> I only have rom and ram-based file systems, so I believe that disk
> caching could and maybe should be reduced to use less space.  Can I

Why?  What's wrong with the way it is?  Is it impacting performance?
Thrashing?  I can see a vague argument that its (nearly) pointless
to cache buffers from ramdisk ... but it would take some work to flesh
out this argument.

That said, you can play with parameters in /proc/sys/vm although
none of those directly affect the buffer cache size.  Indirectly,
setting the flush times to zero might shrink the effective buffer
cache, though... maybe. And it might hurt performance, maybe ...

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
