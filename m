Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 18 Sep 2006 09:17:55 -0700
To: Linuxppc-dev@ozlabs.org
Subject: Is -fno-omit-frame-pointer supported on powerpc?
Message-ID: <20060918161755.GA23407@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I found a buggy interaction between kgdb and -fno-omit-frame-pointer on
ppc that we're discussing on kgdb-bugreport.

I noticed that ppc is excluded from the list of archs on which
CONFIG_FRAME_POINTER depends (in lib/Kconfig.debug).  Are there
known problems with it?  Or is it just not that useful on ppc?

Thanks,
-Dale
