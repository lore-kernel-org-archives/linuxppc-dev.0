Return-Path: <pdfdoc15@yahoo.com>
Received: from web37106.mail.mud.yahoo.com (web37106.mail.mud.yahoo.com
	[209.191.85.108]) by ozlabs.org (Postfix) with SMTP id 2F78F67A5B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 04:34:44 +1000 (EST)
Message-ID: <20060503183443.42040.qmail@web37106.mail.mud.yahoo.com>
Date: Wed, 3 May 2006 11:34:43 -0700 (PDT)
From: Om Vadlapatla <pdfdoc15@yahoo.com>
Subject: RE: Performance improvement Montavista 3.0 MPC8260 by D-cache enable
To: srideep.devireddy@wipro.com, linuxppc-embedded@ozlabs.org
In-Reply-To: <6AD9F6A5F6E096408F0B703773355A07E24DF9@CHN-SNR-MBX01.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

How do you suggest I go about enabling the data cache 
with out running into the machine check exception
(0200 exception). 

I need the data cache as there is lot of data access
in the applications we run on our SDH unit.

OS Montavista 3.0
Processor MPC8260

Register required to madify: HID0 (bit 17 to be set)
=> controlword is: HID0 OR 000004000 => sets the 17th
bit

but this gives me the 0200 exception

are there any kernel routines I can run to get this to
work?

Thank you,
Sincerely,
Om Vadlapatla  

--- srideep.devireddy@wipro.com wrote:

> Data chache is not enabled you have to enable it
> ......
> 
> srideep
> 
> -----Original Message-----
> From:
>
linuxppc-embedded-bounces+srideep.devireddy=wipro.com@ozlabs.org
>
[mailto:linuxppc-embedded-bounces+srideep.devireddy=wipro.com@ozlabs.org
> ] On Behalf Of Om Vadlapatla
> Sent: Wednesday, May 03, 2006 7:57 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Performance improvement Montavista 3.0
> MPC8260 by D-cache
> enable
> 
> I want to confirm if the Montavista linux version
> 3.0
> for the MPC8260 has the data cache working.
> 
> I work on an SDH unit that uses 2 channels and we
> are
> about to recieve a shipment of new harware that has
> to
> support 4 serial optical channels.
> 
> I need to confirm if the version of linux we are
> using
> has the data chache enabled as I am about to spend a
> lot of time on the data cache.
> 
> Thank you,
> Best Regards,
> 
> Om Vadlapatla
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
