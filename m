Return-Path: <jjdanimoth@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id 2D5171007D4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jun 2010 03:46:47 +1000 (EST)
Received: by wwb17 with SMTP id 17so476480wwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 10:46:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikS7AKQ0IaQQebh5MNlXLVEwQmsH8uk5GOwcckd@mail.gmail.com>
References: <AANLkTikS7AKQ0IaQQebh5MNlXLVEwQmsH8uk5GOwcckd@mail.gmail.com>
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Fri, 18 Jun 2010 19:46:25 +0200
Message-ID: <AANLkTilfQ2g5zsvQulS21vvGjl7Qfw5jvdmF60agXBTn@mail.gmail.com>
Subject: Re: How to find macro defination in source code ?
To: "wilbur.chan" <wilbur512@gmail.com>
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

2010/6/18 wilbur.chan <wilbur512@gmail.com>:
> For example, a macro in serial driver 8250.c , SERIAL_PORT_DFNS ,I
> can't find where it is implement.
>
> Is there any solutions to find a macro defination in code ?
>
> Thx

Yes, use the lxr engine [1].


[1] http://lxr.linux.no
