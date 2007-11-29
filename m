Return-Path: <alan@akb.net>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by ozlabs.org (Postfix) with ESMTP id 88C20DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 15:06:38 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so788517ele
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 20:06:37 -0800 (PST)
Message-ID: <bfa0697f0711282006o235c987eg80732114e489befd@mail.gmail.com>
Date: Wed, 28 Nov 2007 21:06:36 -0700
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Timers on mpc8248 etc...
In-Reply-To: <474DFD15.603@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0711281541l31225d59ne78c8fe40286052e@mail.gmail.com>
	<474DFD15.603@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It comes from uboot.  Can you point me in the right direction to make
sure its right?
               PowerPC,8248@0 {
                       device_type = "cpu";
                       reg = <0>;
                       d-cache-line-size = <d#32>;
                       i-cache-line-size = <d#32>;
                       d-cache-size = <d#16384>;
                       i-cache-size = <d#16384>;
                       timebase-frequency = <0>;
                       clock-frequency = <0>;
               };


On 11/28/07, Scott Wood <scottwood@freescale.com> wrote:
> Alan Bennett wrote:
> > I've got a routine that needs to delay for X microseconds, this is a
> > must.  The command after schedule_timeout must has to wait for the HW
> > to complete a task that takes X microseconds.
> >
> > I would think that one way to do this is with a simple
> > schedule_timeout.  But in the example below, the time that passes from
> > run1() to dontrun() is far less than 3.2 msecs.  Infact, sometimes its
> > ~ 800 micros according the a analyzer looking at points triggered in
> > run1() and donrun().  Could this be a configuration problem with the
> > timer/interrupt that generates the jiffies?
>
> Are you sure the timebase frequency is set correctly in the device tree?
>
> -Scott
>
