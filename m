Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000b01c2f342$8347d830$337ceccb@dasan.com>
From: "Young-Han, Kim" <yhkim@da-san.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC 8xx as SPI slave...
Date: Wed, 26 Mar 2003 11:50:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Hi!
  If you have any experience for SPI slave on MPC 8xx,
please advice to me.

  I will use the MPC 8xx as SPI slave, the SPI master is not MPC 8xx.
  Currently, using the SPI interrupt for RX/TX on MPC 8xx.
  The SPI write operation on SPI master is run very well.
  But, SPI read operation on SPI master is not so good.
  When SPI read operation on SPI master, the CPM of MPC 8xx
report the SPI TX interrupt as TX done.
  But, the MPC 8xx SPI not transmit that data on SPI bus,
just transmit old TX data.
  In second SPI read operation on SPI master, the MPC 8xx SPI
transmit previous data of TX BD.
  It means that the MPC 8xx SPI not transmit the data on time.
  I was checked with oscilloscope.
  If you know the reason of this problem, please answer to me.

from
Young-Han, Kim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
