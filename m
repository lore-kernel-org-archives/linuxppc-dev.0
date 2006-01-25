Return-Path: <carlos@kenati.com>
Received: from mail.kenati.com (unknown [69.90.147.196])
	by ozlabs.org (Postfix) with ESMTP id 0F1B068A6A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 07:30:36 +1100 (EST)
Message-ID: <43D7DC34.8050604@kenati.com>
Date: Wed, 25 Jan 2006 12:14:44 -0800
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: Frank <frannk_m1@yahoo.com>
Subject: Re: 2.4.x vs 2.6.x performance
References: <20060123042413.806.qmail@web32201.mail.mud.yahoo.com>
In-Reply-To: <20060123042413.806.qmail@web32201.mail.mud.yahoo.com>
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

Frank wrote:

>I remember reading a while back that the 2.6 kernel is
>considerably slower then the 2.4 kernel (Wolfgang Denx). Has
>anybody taken any performance measurements on a later kernel
>version to see if the above still hods true?
>
>I'm thinking about moving to 2.6 since a lot of open source
>projects have stopped suporting the 2.4 kernel.
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
Hi Frank,

While at my previous company we tried to move to the 2.6 kernel (can't 
remember the version, however it was a little over a year ago) from the 
2.4.20 kernel. The 2.6 kernel could not keep up with our stress tests, 
not even close. Unfortunately, I don't have any hard data. We spent 
about 2 weeks trying to figure out why  the performance degradation. 
However, since there was no real need to use the 2.6 kernel other than 
for better performance, and due to other pressing projects, management 
decided to put on hold the upgrade to 2.6, and as far as I know they are 
still on the 2.4 kernel. A lot has changed on 2.6 since then, so maybe 
the performance is better now. You can always compare them both and post 
your results.

Thanks,


Carlos Munoz
