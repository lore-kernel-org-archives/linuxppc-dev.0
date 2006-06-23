Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17563.54330.600099.894958@cargo.ozlabs.ibm.com>
Date: Fri, 23 Jun 2006 21:44:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: "merge" branch reset in powerpc.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you are following the powerpc.git tree, and you pull the "merge"
branch, you will need to reset it to have commit ID
5fa21d821f6972e70942f2c555ec29dde962bdb2 as its head.  That's also the
head of the "master" branch and of Linus' linux-2.6 tree at the
moment.

This is because there was a merge between the "master" branch and the
linux-2.6 tree which Linus didn't pull - instead he did a new merge.
The merge I did is now redundant, and needs to be removed to keep the
powerpc and linux-2.6 trees in sync.

Paul.
