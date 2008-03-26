Return-Path: <olof@lixom.net>
Date: Tue, 25 Mar 2008 20:56:25 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH 0/2] Two more pasemi_mac patches for 2.6.26
Message-ID: <20080326015625.GA23103@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jeff,

The below two patches go on top of the previous patches that were acked
by you but applied to pasemi.git for feed up through powerpc.git.

One is a couple of fixes for various corner cases in the jumbo support
configuration. The second is addition of netpoll support, from Nate
Case.

Review/ack would be appreciated, I'll feed them up the same path as the
other changes.


-Olof
