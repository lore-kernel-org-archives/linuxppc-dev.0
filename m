Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id 0EFB5DDF57
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 02:03:59 +1100 (EST)
Message-ID: <45C352DB.8070409@omnisys.se>
Date: Fri, 02 Feb 2007 16:03:55 +0100
From: Magnus Hjorth <mh@omnisys.se>
MIME-Version: 1.0
To: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: ELDK glibc fcntl(socketFd, F_SETFL, flags) causes Seg Fault
References: <loom.20070201T073939-302@post.gmane.org>
In-Reply-To: <loom.20070201T073939-302@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Ng wrote:
> Hi,
>
> My application Seg Faults when I try to set flags for my socket fd.
>
> Then I try getting the fd flags:
> fcntl(fd, F_GETFL, flags)
>   
Shouldn't it be &flags ??

-- 

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  Västra Frölunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se 
