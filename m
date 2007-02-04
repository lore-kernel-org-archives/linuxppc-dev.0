Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Sun, 4 Feb 2007 03:42:39 +0100
References: <45BE4ED0.5030808@us.ibm.com> <200702030840.06270.arnd@arndb.de>
	<45C4EA7D.4000709@us.ibm.com>
In-Reply-To: <45C4EA7D.4000709@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702040342.39626.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 03 February 2007 21:03, Maynard Johnson wrote:
> I presume you mean 'object_id'.=20

Right, sorry for the confusion.

> What you're asking for is a new =20
> requirement, and one which I don't believe is achievable in the current=20
> timeframe. =A0Since this is spufs code that's dynamicaly loaded into the=
=20
> SPU at runtime, the symbol information for this code is not accessible=20
> to the userspace post-processing tools.

We can always fix the user space tool later, but it is important to
get at least the kernel interface right, so we can add the functionality
later without breaking new user space on old kernels or vice versa.

> It would require an altogether =20
> different mechanism to record samples along with necessary information,=20
> not to mention the changes required in the post-processing tools. =A0This=
=20
> will have to be a future enhancement.

So what do you do with the samples for object_id =3D=3D 0? I would expect t=
hem
to be simply added to the sample buffer for the kernel, which is sort
of special in oprofile anyway.

	Arnd <><
