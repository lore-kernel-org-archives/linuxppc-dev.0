Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 79716DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 22:35:36 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so285562waf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 04:35:34 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 19 Mar 2009 07:35:10 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Manish D <manish2312@gmail.com>
Subject: Re: [newbie] uboot relevant !
Message-ID: <20090319113510.GA2381@yoda.jdub.homelinux.org>
References: <d7ca49770903181013h20368741t7cd4653a83286006@mail.gmail.com>
	<d7ca49770903182314j6849decbhaa1039dbb5276f86@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d7ca49770903182314j6849decbhaa1039dbb5276f86@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 11:44:54AM +0530, Manish D wrote:
>Hi all,
>
>please bear these probably newbie questions.
>
>I am trying to port a BSP from 2.4 to 2.6 for a mpc834x based platform.
>I am building and working on the device tree now.
>Is there a way build this bsp, without taking the device tree route ?
>I guess not.
>
>The uboot version i am using is old and not sure how this uboot can
>pass the device tree details while booting the kernel.
>Is there a way to load 2.6 kernel from this older bootloader (cuImage
>?) or will i have to upgrade to a newer uboot ?

Yes, cuImage should be what you are looking for.

josh
