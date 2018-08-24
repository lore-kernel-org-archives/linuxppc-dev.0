Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xq9j240LzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 04:11:50 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: FSL/NXP P5020: USB problems with the latest Git kernels
Message-Id: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
Date: Fri, 24 Aug 2018 20:11:43 +0200
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

There are USB problems with P5020 boards with the latest Git kernels.

Some users reported the following error messages:

skateman@X5000LNX:~$ grep -i -E 'usb.*error' /var/log/syslog
Aug 24 13:12:50 X5000LNX kernel: [ 6.552303] usb 1-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 6.649376] usb 2-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 6.794158] usb 1-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 6.883156] usb 2-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 7.139155] usb 1-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 7.226156] usb 2-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 7.363155] usb 1-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 7.451156] usb 2-1: device descriptor read=
/64, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 8.521156] usb 1-1: device not accepting a=
ddress 4, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 8.609156] usb 2-1: device not accepting a=
ddress 4, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 9.057155] usb 1-1: device not accepting a=
ddress 5, error -32
Aug 24 13:12:50 X5000LNX kernel: [ 9.145157] usb 2-1: device not accepting a=
ddress 5, error -32

I don=E2=80=99t have a P5020 board here. That means I can=E2=80=99t bisect a=
nd test. Therefore I need your help. The problematic Git commit must be some=
where between 22/08/18 1:20 PM UTC and 23/08/18 10:49 AM UTC.
The Git kernel from 22/08/18 1:20 PM UTC works with USB devices.
Could you please compile a Git kernel and test it on your P5020 board?

Thanks,
Christian=
