Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 45190679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 02:09:24 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so203495wri
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 09:09:15 -0700 (PDT)
Message-ID: <a0bc9bf80609280909r13e9ea31ldf0630969416cbff@mail.gmail.com>
Date: Fri, 29 Sep 2006 00:09:14 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
In-Reply-To: <7178D84E-0290-4D3E-905E-C26C9908F40E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <451B8553.30107@freescale.com>
	<7178D84E-0290-4D3E-905E-C26C9908F40E@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Sep 28, 2006, at 3:18 AM, Li Yang wrote:
>
> > Paul,
> >
> > The series of patches add generic QE infrastructure called
> > qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> > QE device drivers such as ucc_geth driver.
> >
> > This version updates QE interrupt controller to use new irq
> > mapping mechanism, addresses all the comments received with
> > last submission and includes some style fixes.
> >
> > v2 change: Change to use device tree for BCSR and MURAM;
> > Remove I/O port interrupt handling code as it is not generic
> > enough.
>
> Before accepting any of this code, I'd like to see what the drivers
> look like that are using it.  Its hard to make significant comments w/
> o seeing what the consumers of all the 'lib' code look like.

Current in-tree user of the lib is driver/net/ucc_geth.c.  There is
also QE ATM driver which is included in Alex's 8360sar project.  QE
USB host/client drivers are in Freescale LTIB BSP.

- Leo
