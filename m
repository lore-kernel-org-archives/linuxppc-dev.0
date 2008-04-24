Return-Path: <dhlii@picocomputing.net>
Received: from outbound-mail-06.bluehost.com (outbound-mail-06.bluehost.com
	[69.89.17.206]) by ozlabs.org (Postfix) with SMTP id 4E23EDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 12:09:11 +1000 (EST)
Message-ID: <480FEA44.8090105@picocomputing.net>
Date: Wed, 23 Apr 2008 22:02:44 -0400
From: "David H. Lynch Jr." <dhlii@picocomputing.net>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: simpleboot
References: <480F8148.8090906@picocomputing.net>	
	<fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>	
	<480F917F.8040809@picocomputing.net>
	<1208999357.2946.6.camel@vader.jdub.homelinux.org>
In-Reply-To: <1208999357.2946.6.camel@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Josh Boyer wrote:
> simpleboot is in Linus' tree now.  It went in with the first pull
> request paulus sent for .26.
>   
    I got it, now to figure it out.
> I don't understand that comment anyway though.  If you're working with a
> PowerPC board, why aren't you using the powerpc tree (paulus') to begin
> with?  "Backporting" pieces of it to some other tree seems to be a waste
> of time to me...
>   
    I am updating a port I did in 2005 ? based on the  ml403 port that
was in at that time.
    But it is an independent BSP. I need to move it to the current
powerpc/devicetree,
    but I have to do so without breaking alot of things we have have
working for years.

    At the moment I am somewhat "surely" about a number of the issues
related to the powerpc/devicetree migration.
    Aside from the BSP issues, this breaks my boot monitor, and is going
to require adding alot more code than I can either justify
    or see as necescary because there are some aspects of how the
devicetree/powerpc stuff is architected that
    politely I think are brain dead.

    But I will get over it - probably. There just may be a bit of
cursing and foul language before things work.

-- 
Dave Lynch                                          Pico Computing, Inc.
Software Development                                      Embedded Linux
717.627.3770      dhlii@picocomputing.net   http://www.picocomputing.com
fax: 1.253.369.9244                                 Cell: 1.717.587.7774
Tiny Mighty Machines
