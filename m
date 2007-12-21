Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CA2B0DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:16:47 +1100 (EST)
Date: Fri, 21 Dec 2007 23:18:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3 0/4] device_type/compatible cleanups
Message-ID: <20071221201844.GA4278@localhost.localdomain>
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

Here is the third version (let's hope the last :-).

Changes since v2:
- SPI conversion fixed and actually tested on MPC8323E-RDB to not
  break anything;
- Few more users of device_type = "qe" converted to
  compatible = "fsl,qe";
- Got Ack on SPI part from David.

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
