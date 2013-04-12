Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0845C2C00B0
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Apr 2013 07:15:12 +1000 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
 id 1UQl4l-0000jx-9u
 for linuxppc-dev@ozlabs.org; Fri, 12 Apr 2013 23:00:03 +0200
Received: from static-66-160-121-125.t1.cavtel.net ([66.160.121.125])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Apr 2013 23:00:03 +0200
Received: from solanchala by static-66-160-121-125.t1.cavtel.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Apr 2013 23:00:03 +0200
To: linuxppc-dev@ozlabs.org
From: Solan <solanchala@yahoo.com>
Subject: Re: MPC 8260/70 MCC SI Clocking and TSA Sync
Date: Fri, 12 Apr 2013 20:55:36 +0000 (UTC)
Message-ID: <loom.20130412T225335-987@post.gmane.org>
References: <20051003165435.70417.qmail@web34701.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Manish Joshi <mjoshi_blr <at> yahoo.com> writes:

> 
> 
> Hi,
>  
> I am trying to bring up MCC (Multi Channel Communication controller) on 
MPC8270 board for T1/E1.
> The overall configuration looks fine since I am able to have a 
communication properly if I do a T1 Cross over Loopback and tx/rx 
HDLC data.
> The things do not work smoothly if I connect my T1 line with an external 
device and start HDLC.
> I am seeing 'NO' (Rx Non-Octet Alligned Frame) errors in my rx buffers. 
Sometimes I also see Rx abort errors.
> I do not see this issue on the tx side i.e the external device does not 
report any of these when I tx HDLC data to it.
>  
> Does anybody have any experience dealing with this ? 
>  
> As far as clocking and sync with TSA is concerned, I have just 
configured 
> CMXSI2CR register with 0x00 ( I have only TDM2A driven by CLK1) and 
nothing else. 
> Do I need to do something more for clocking etc? Also I am doing this 
before SI initialisation.
> I will also try doing it just after TDM init and see if it helps.
> Please help.
>  
> Thanks,
> -Manish
>  
>  
>  
>  
> 
> 		Yahoo! for GoodClick here to donate to the Hurricane 
Katrina relief effort. 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded <at> ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Hi Manesh,
Do you by chance have the linux driver you can share for implementing MCC 
driver for MPC 8270. I am trying to implement a driver for enabling the 
MCC on MPC 8250 and will be great to have a reference code.
Regards,
Solan
