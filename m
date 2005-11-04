Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 6E6C468679
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 21:35:08 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jA4Ah2xg000299
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 Nov 2005 12:43:03 +0200 (EET)
Message-ID: <436B380A.7060709@intracom.gr>
Date: Fri, 04 Nov 2005 12:29:30 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
References: <200511032039.27395.pantelis.antoniou@gmail.com>
	<200511041133.23086.david.jander@protonic.nl>
In-Reply-To: <200511041133.23086.david.jander@protonic.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: Put CPM1 config option
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
> On Thursday 03 November 2005 19:39, Pantelis Antoniou wrote:
> 
>>[...]
>>+config CPM1
>>+	bool
>>+	depends on 8xx
>>+	default y
>>+	help
>>+	  The CPM1 (Communications Processor Module) is a coprocessor on
>>+	  embedded CPUs made by Motorola.  Selecting this option means that
>>+	  you wish to build a kernel for a machine with a CPM1 coprocessor
>>+	  on it (8xx, 827x, 8560).
> 
> 
> Not that the help of a hidden bool is of much importance, but what have the 
> mpc827x and mpc8560 to do with a CPM1? Those are PQ2 processors AFAIK.
> Why does this option have a help anyway?
> 
> Greetings,
> 

Nothing - I was posted in a hurry.
Cut and paste :\

-- Pantelis
