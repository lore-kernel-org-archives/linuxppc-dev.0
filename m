Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000901c2f37c$44a2a800$337ceccb@dasan.com>
From: "Young-Han, Kim" <yhkim@da-san.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20030326070322.93F25C58BA@atlas.denx.de>
Subject: Re: MPC 8xx as SPI slave... 
Date: Wed, 26 Mar 2003 18:44:17 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang Denk,

  Thanks for your reply...

> This could be a cache issue. Which source is your SPI driver based on?

  Also, I was doubt the cache problem.
  I'll  check again...
  My code is based on your lwmon_spi.c just basic function.


> Does the 8xx transfer data at all? You know, SPI has a very, very low
> priority onthe CPM, so it will be starved  by  any  other  I/O  (like
> ethernet and especially USB).

  Just transmit the previous data of TX BD not on time.
  I'll check the priority...


  Thanks!

Best Regards
Young-Han, Kim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
