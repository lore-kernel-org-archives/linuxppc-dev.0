Date: Tue, 9 Apr 2002 23:13:36 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: xfs working in benh kernel
Message-ID: <20020409231336.B20630@plato.local.lan>
References: <64EAEAA6-4C1F-11D6-841B-003065ABC1E2@ualberta.ca>
Mime-Version: 1.0
In-Reply-To: <64EAEAA6-4C1F-11D6-841B-003065ABC1E2@ualberta.ca>; from mccrosky@ualberta.ca on Tue, Apr 09, 2002 at 07:07:57PM -0600
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 07:07:57PM -0600, Jesse McCrosky wrote:
>
> I have managed to get xfs (the filesystem, not the font server) working
> in benh's 2.4.19-pre6 kernel.  I'm new to this list, so I'll just ask:
> is this the sort of thing that is worth putting together a patch for?
> And if so, to whom should I send the patch?

have you run all the XFS regression tests?  just getting the patches
merged and making it compile does not necessarily mean that it will
work properly, XFS works closly with the VM so if the VM changes XFS
may need to be adapted.

most people do not need to run the benh tree any longer, 2.4.18 is in
good shape.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
