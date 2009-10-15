Return-Path: <paul.gibson2074@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id E2A9DB7B80
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 22:21:07 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so269742qwd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 04:21:06 -0700 (PDT)
Message-ID: <4AD70585.40302@gmail.com>
Date: Thu, 15 Oct 2009 21:20:37 +1000
From: Paul Gibson <paul.gibson2074@gmail.com>
MIME-Version: 1.0
Subject: Re: MPC5121 CAN and USB
References: <4AD5ADC9.30503@embedded-sol.com> <4AD6F172.6030407@aimvalley.nl>
	<4AD6FD4E.9060507@marel.com>
In-Reply-To: <4AD6FD4E.9060507@marel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: paul.gibson2074@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In my opinion the best place is the BSP available on the MPC5121e page 
on the Freescale site.

I actually use the kernel in the git repository here which is similar to 
the BSP:
http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/ltib-mpc5121ads-20090602 
or here:
http://git.denx.de/?p=linux-mpc512x.git;a=summary

I have found both to be very stable, also with the CAN and USB.

Paul

Kári Davíðsson wrote:
> Hello,
>
> Where is the most current linux work for the Freescale MPC5121 cpu 
> stored.
> What I am specifically interested in at this time is the CAN and USB 
> subsystems.
>
> rg
> kd
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
