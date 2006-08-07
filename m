Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
Date: Mon, 7 Aug 2006 16:59:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Who cares about PReP?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I started looking at moving the PReP code over to arch/powerpc.  I am
struck by how many ifdefs there are in there to set things up for
particular individual PReP implementations.  We can do better than
that, I'm sure, but the issue becomes one of testing.  The only PReP I
have here is an RS/6000 43p-140.

Who else has a PReP system and would be willing to do some testing and
debugging?  If so, what sort of PReP is it?

Paul.
