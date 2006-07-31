Return-Path: <mike@compulab.co.il>
Received: from mail.linux-boards.com (mail.linux-boards.com [62.90.235.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A09D67A3F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 17:14:07 +1000 (EST)
Message-ID: <44CDBA3C.2040402@compulab.co.il>
Date: Mon, 31 Jul 2006 10:07:24 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Uros Borovsak <borovsak@razvoj-verbic.si>
Subject: Re: Host USB on MPC8247
References: <44BF88A2.6080003@razvoj-verbic.si>
	<44C9F398.4060109@razvoj-verbic.si>
In-Reply-To: <44C9F398.4060109@razvoj-verbic.si>
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

Uros Borovsak wrote:

>Hello,
>
>Can you at least give me some idea how difficult would it be to patch 
>USB part of kernel from 2.6.13 to 2.6.10?
>  
>
As far as I know USB core undergone signifcant changes between 2.6.10 
and 2.6.13. Still it's hard to tell how difficult would it be to 
backport USB from 2.6.13 to 2.6.10.
Besides, it maybe worth upgrading your kernel instead of backporing USB 
to 2.6.10.

>Are changes only in usb part of kernel, or are there also some changes 
>in other parts of kernel, that I would have to port?
>
>Thanks,
>
>Best regards
>
>Uros
>
>
>  
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
>  
>


-- 
Sincerely yours,
Mike Rapoport
