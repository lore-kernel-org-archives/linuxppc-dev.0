Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 9A00967C37
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 02:58:48 +1000 (EST)
Received: from zaphod.acdstar.com (zaphod.int.acdstar.com [192.168.2.100])
	by mail.acdstar.com (8.13.0/8.13.0) with ESMTP id j6BGfBpf029863
	for <linuxppc-embedded@ozlabs.org>; Mon, 11 Jul 2005 11:41:11 -0500
Message-Id: <6.2.3.4.1.20050711112652.02b82cc8@mail.int.acdstar.com>
Date: Mon, 11 Jul 2005 11:43:36 -0500
To: linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
In-Reply-To: <20050711113948.vznzvgxu15nkkwcg@webmail.ellipticity.com>
References: <20050711113948.vznzvgxu15nkkwcg@webmail.ellipticity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: Re: MPC5200 Rev. B
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

mgberry@ellipticity.com wrote:
>Has anyone experienced any issues with the Rev. B silicon for the 
>MPC5200.  We are seeing Linux hanging and are suspecting the SDRAM 
>errata for Rev. B.  If we disable the cache this seems to improve 
>but will still crash over time in heavy loads.  We have not seen any 
>of these type issues with the original rev.

Are you sure you have revision B of the MPC5200?  Freescale has 
announced a "B" version, but I don't believe that any of them have 
hit the public yet.  There may be some engineering grade samples out 
there. (Let me know if you really do have "B" parts.  Freescale has 
been telling me "real soon now" since last year)

More likely you're seeing the "B" in the part number, as in 
MPC5200CBV400.  The chip revision is the "mask set" on the next line 
of printing.  The latest public version I know of is L25R.

The L25R version has a major bug that you basically can't use two CS 
pins for SDRAM, and the DDR implimentation is borderline at best.

Exactly what problems are seeing?  What hardware platform do you run 
on?  We're using an MPC5200 with SDR-SDRAM running at 132MHz (two 16 
bit SDRAM devices), and haven't seen any issues.

I don't know what bootloader you're using, but I believe uboot has 
basic memory testing built in.  This would allow you to isolate 
memory issues from software issues.

Eric

------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
