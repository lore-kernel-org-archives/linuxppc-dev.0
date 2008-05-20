Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 09AB8DE596
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:13:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Oops in fs_enet driver with preempt-rt
Date: Tue, 20 May 2008 11:14:01 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E73C6@ismail.innsys.innovsys.com>
In-Reply-To: <4832F139.1020502@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B046E728C@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E72C3@ismail.innsys.innovsys.com>
	<4832F139.1020502@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Rune Torgersen wrote:
>> 0xc0196d84 is in fs_enet_interrupt
>> (drivers/net/fs_enet/fs_enet-main.c:473).
>> 468                     if (fpi->use_napi)
>> 469                             int_clr_events &=3D ~fep->ev_napi_rx;
>> 470 471                     (*fep->ops->clear_int_events)(dev,
>> int_clr_events); 472
>> 473                     if (int_events & fep->ev_err)
>> 474                             (*fep->ops->ev_error)(dev,
>> int_events); 475 476                     if (int_events &
>> fep->ev_rx) { 477                             if (!fpi->use_napi)
>> (gdb)
>=20
> Do you have shared interrupt debugging turned on?  That breaks this
> driver, and a patch to remove the shared flag was nacked in favor of
> actually fixing the driver, which I haven't gotten around to.
>=20
> -Scott

Hmm.... ttyCPM1 output seems to be kinda garbled... Any ideas?
Incomplete locking between printk and userland use of ttyCPM1 as
console?

kjour[  OK  ]   nal
 stdrtiag. nCom it mnteivalr5 s cones
dXT3EFS  n soa7,dint rnae jolrnau
ElT3-Xs: founmed tilefystsm weth irdeoed ratadmod .
ek/*    [  Removing /var/run/* and /var/locp... [  OK  ]
Creating new /var/run/utmlogin /fastboot and /forcefsck...      OK  ]
Removing possible /etc/noBringing up the loopback interface...  [  OK  ]
OK  ]
OK  ] Entering runlevel: 3 hostname to 9919_unit1_c
Starting the i2c_8266 driver: i2
_82c6: 6odume llcenie 'snspucifeed'itai ts nernkl.
                                                  e[ OK ]
