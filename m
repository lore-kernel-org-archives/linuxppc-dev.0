From: "Rob Taylor" <robt@flyingpig.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: switching linux kernels
Date: Wed, 27 Sep 2000 10:31:56 +0100
Message-ID: <001801c02865$c71c1c10$b400a8c0@eventhorizon>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
In-Reply-To: <39D18CAD.FDC505E0@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Please don't use in/out macros on PowerPC....especially on 8xx their
> underlying address arithmetic will likely break more things that it
> fixes.
> Use memory mapped I/O (readb/writeb, etc.) and ioremap().....

presumably this is due to int in/out macros adding _IO_BASE to the pointer? So
am I right in thinking that it makes sense to use in/out for ISA accesses (if
_IO_BASE is set correctly for your platform) and readb/writeb/.. for the rest of
your memory mapped registers?

Thanks,
Rob Taylor
Flying Pig Systems


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
