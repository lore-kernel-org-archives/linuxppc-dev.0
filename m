Return-Path: <grant.likely@secretlab.ca>
Date: Thu, 19 Jul 2007 12:34:15 -0600
From: grant.likely@secretlab.ca
Subject: [PATCH 0/4] Series short description
To: linuxppc-dev@ozlabs.com
Message-id: <20070719183415.7458.42622.stgit@trillian>
Content-type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series makes the mpc8349emitx* cuImage work 'out of the box'
Major changes are adding the linux,network-index property to the Ethernet
nodes and adding a default linux,stdout-path to the .dts files.  With
these changes, a cuImage created by 'make mpc834x_itx_defconfig; make zImage'
should boot without changes.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
