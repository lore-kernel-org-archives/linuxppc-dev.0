Return-Path: <pku.leo@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by ozlabs.org (Postfix) with ESMTP id CE41EDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 13:51:41 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so1742954tib.13
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Sep 2008 20:51:40 -0700 (PDT)
Message-ID: <2a27d3730809022051p73cdfe92sde02996c6f22db9b@mail.gmail.com>
Date: Wed, 3 Sep 2008 11:51:39 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v3] usb: add Freescale QE/CPM USB peripheral controller
	driver
In-Reply-To: <200809021401.25506.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1220356690-8028-1-git-send-email-leoli@freescale.com>
	<200809021401.25506.arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 2, 2008 at 8:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 02 September 2008, Li Yang wrote:
>> Some of Freescale SoC chips have a QE or CPM co-processor which
>> supports full speed USB.  The driver adds device mode support
>> of both QE and CPM USB controller to Linux USB gadget.  The
>> driver is tested with MPC8360 and MPC8272, and should work with
>> other models having QE/CPM given minor tweaks.
>>
>> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> All my previous review comments have been addressed.
>
>> +     udc_controller->soc_type = (unsigned long)np->data;
>
> I'm not sure about this line, shouldn't that be
>        udc_controller->soc_type = (unsigned long)match->data; ?

Oops.  You are right.

- Leo
