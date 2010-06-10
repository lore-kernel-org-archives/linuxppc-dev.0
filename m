Return-Path: <paulus@ozlabs.org>
Date: Thu, 10 Jun 2010 14:23:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100610042351.GA17989@drongo>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
	<20100604065145.GA2408@in.ibm.com>
	<20100604090648.GC26154@brick.ozlabs.ibm.com>
	<20100607070351.GA3853@in.ibm.com>
	<20100607112559.GA2419@brick.ozlabs.ibm.com>
	<20100609103223.GA10656@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100609103223.GA10656@in.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 04:02:23PM +0530, K.Prasad wrote:

> (Given that it's your idea I've added your
> signed-off too).

Actually, you should never add someone else's signed-off-by unless
they specifically ask you to.  The signed-off-by lines are supposed to
show the path that the patch took to get into the tree, so in general
only the original author(s) and the maintainers who passed the patch
along should add signed-off-by lines.  It would only be a maintainer
who would add someone else's signed-off-by, and then only if someone
who needs to sign off on the patch had forgotten and then asked the
maintainer to correct their mistake.

In this case the appropriate way to give credit would be just a
sentence in the patch description; no formal tag is needed.

Paul.
