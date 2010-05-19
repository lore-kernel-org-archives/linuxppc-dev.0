Return-Path: <jjdanimoth@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 3D034B7D64
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 19:01:43 +1000 (EST)
Received: by wyb40 with SMTP id 40so411662wyb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 02:01:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1274219376.21352.857.camel@pasglop>
References: <201005182116.04092.jjdanimoth@gmail.com>
	<1274219376.21352.857.camel@pasglop>
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Wed, 19 May 2010 11:01:21 +0200
Message-ID: <AANLkTim594fXeuOccGqcFzJlcasFjE9XXj082gMlVu05@mail.gmail.com>
Subject: Re: PATA/legacy IDE subsystem on PowerMac
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/5/18 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
[cut]
> Nothing obvious... the disk seem to be detected properly. Do you have
> the support for mac partitions and the SCSI disk driver (BLK_DEV_SD)
> enabled ?

The PATA modules was built statically, and BLK_DEV_SD as a module (and
not included in the ramfs).
Now it boot correctly, many thanks.

Have a nice day
