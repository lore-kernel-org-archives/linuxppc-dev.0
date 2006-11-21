Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17762.26999.152198.792581@cargo.ozlabs.ibm.com>
Date: Tue, 21 Nov 2006 13:50:31 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
In-Reply-To: <4559099A.6060805@am.sony.com>
References: <4554DACB.8060809@am.sony.com> <20061110152310.7419ef3e@pb15>
	<4559099A.6060805@am.sony.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> I had it as ps3, but I was told to change it to ps3pf.  I don't
> like that name though.

The "ps3pf" name is pretty meaningless.  I think that, at the very
least, the directory name should be arch/powerpc/platforms/ps3.
Unless Arnd is prepared to argue strongly to the contrary, I will be
rejecting patches that create a platforms/ps3pf directory.

Regards,
Paul.
