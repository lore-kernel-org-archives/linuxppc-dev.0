Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A40F3DDF18
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 01:26:45 +1100 (EST)
Date: Tue, 8 Jan 2008 17:26:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v4 0/4] device_type/compatible cleanups
Message-ID: <20080108142634.GA5989@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

The fourth version follows...

Changes since v3:
- Thanks to reviewers, few glitches found and fixed;
- New conversion: device_type = "qeic" to compatible = "fsl,qe-ic";
- Documentation updated.

Changes since v2:
- SPI conversion fixed and actually tested on MPC8323E-RDB to not
  break anything;
- Few more users of device_type = "qe" converted to
  compatible = "fsl,qe";
- Got Ack on SPI part from David Brownell.

Changes since v1:
- Device tree lookup changes should be backward compatible with
  older dtbs;
- Few of_put_node() cleanups;
- cell-index property added to spi nodes;
- cpm-muram{,-data} added as an addition to qe-muram{,-data}.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
