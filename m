Return-Path: <carlos@kenati.com>
Received: from mail.kenati.com (unknown [69.90.147.196])
	by ozlabs.org (Postfix) with ESMTP id DF61F679F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 10:09:49 +1000 (EST)
Message-ID: <446918C2.2000105@kenati.com>
Date: Mon, 15 May 2006 17:11:46 -0700
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: route problem and simple sniffer
References: <20060515232925.C2F24353B1A@atlas.denx.de>
In-Reply-To: <20060515232925.C2F24353B1A@atlas.denx.de>
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

Wolfgang Denk wrote:

>In message <200605152209.13033.antonio.dibacco@aruba.it> you wrote:
>  
>
>>Anyone knows a lightweight sniffer for linux embedded?
>>    
>>
>
>tcpdump ?
>
>Best regards,
>
>Wolfgang Denk
>
>  
>
Yes, that's what I do. I run the following command on my embedded device:

    tcpdump -i eth2 -s 1500 -w /tmp/tcpdump.log

and then upload the tcpdump.log file to my desktop and view it with 
ethereal.


Carlos
