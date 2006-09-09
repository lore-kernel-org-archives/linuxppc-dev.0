Return-Path: <dan.gora@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id D449867BAA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Sep 2006 11:09:14 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so1018438pyc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Sep 2006 18:09:13 -0700 (PDT)
Message-ID: <4779de450609081809g33187e96vf2754af95c7e8514@mail.gmail.com>
Date: Fri, 8 Sep 2006 22:09:12 -0300
From: "Dan Gora" <dan.gora@gmail.com>
To: linuxppc-embedded@ozlabs.org,
	"Laurent Pinchart" <laurent.pinchart@tbox.biz>
Subject: RE: MPC8360E USB Host Controller Driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Message: 1
> Date: Fri, 8 Sep 2006 11:27:59 +0800
> From: "Li Yang-r58472" <LeoLi@freescale.com>
> Subject: RE: MPC8360E USB Host Controller Driver
> To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>,
>        <linuxppc-embedded@ozlabs.org>
> Cc: n.balaji@gdatech.co.in
> Message-ID:
>        <4879B0C6C249214CBE7AB04453F84E4D14C864@zch01exm20.fsl.freescale.net>
> Content-Type: text/plain;       charset="US-ASCII"
>
> > Could you give a direct link ? I've been browsing around the
> > Freescale website for an hour, downloaded hundreds of
> > megabytes of archives but haven't been able to find the
> > MPC8360E USB Linux driver.
> >
> > Laurent Pinchart

Hi Laurent,

I believe that I recall seeing the USB drivers in the "MPC8360E Device
Drivers - Release 1.1 GPL ", accessible from the main 8360 page.

http://www.freescale.com/files/netcomm/software/device_drivers/MPC8360EGPLDRV.zip

One little gotcha... When you unzip this archive, it's a windows
executable, but it doesn't have the '.exe' extension on the file, so
you'll need to add it by hand.  I had to "contact my local FAE" just
to figure out that one when the darn thing wouldn't run.  Too many
years of using Unix I guess.

> >
> > PS: Am I the only one to get lost almost every time when I
> > look for information on www.freescale.com ?

No, rest assured, you're not.  Try finding any information about the
eval board for the 8360 on freescale.com.


-dan
