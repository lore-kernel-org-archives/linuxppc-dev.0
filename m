Return-Path: <manish2312@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id DD452DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 17:14:55 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so258105yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 23:14:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d7ca49770903181013h20368741t7cd4653a83286006@mail.gmail.com>
References: <d7ca49770903181013h20368741t7cd4653a83286006@mail.gmail.com>
Date: Thu, 19 Mar 2009 11:44:54 +0530
Message-ID: <d7ca49770903182314j6849decbhaa1039dbb5276f86@mail.gmail.com>
Subject: [newbie] uboot relevant !
From: Manish D <manish2312@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

please bear these probably newbie questions.

I am trying to port a BSP from 2.4 to 2.6 for a mpc834x based platform.
I am building and working on the device tree now.
Is there a way build this bsp, without taking the device tree route ?
I guess not.

The uboot version i am using is old and not sure how this uboot can
pass the device tree details while booting the kernel.
Is there a way to load 2.6 kernel from this older bootloader (cuImage
?) or will i have to upgrade to a newer uboot ?

Any relevant pointers for this would be appreciated.

TIA,
Manish
