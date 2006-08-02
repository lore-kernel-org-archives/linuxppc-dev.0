Return-Path: <marvin24@gmx.de>
From: marvin <marvin24@gmx.de>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: lockup during powersave on G3
Date: Wed, 2 Aug 2006 07:47:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608020747.50765.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


hi,

since kernel 2.6.18-rc1 my b/w G3 mac locks up every time it goes into 
powersave mode. Before trying to bisect, is there a candidate I can try to 
revert?

marc
