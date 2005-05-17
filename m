Return-Path: <mike@compulab.co.il>
Received: from alex (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 1670F679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 15:56:50 +1000 (EST)
Message-ID: <428995CB.4050301@compulab.co.il>
Date: Tue, 17 May 2005 08:57:15 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050516232744.F106DC1512@atlas.denx.de>
In-Reply-To: <20050516232744.F106DC1512@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 - USB HCI drivers.
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

>In message <61cc712d050516153941bc3b26@mail.gmail.com> you wrote:
>  
>
>>>My advice: use a _real_ USB controller.
>>>      
>>>
>>Are there known problems with CPM-based USB controllers?  I'm
>>    
>>
>
>Ummmm... yes, there are. Especially if you want to use it as  a  host
>comtroller  (which  is  never  was designed for). Even more, if there
>might be other periopherals in your system that might need  a  bit  a
>CPM performance. Or ...
>
>  
>
Do you know if the same is applicable to CPM2 USB controllers present 
for example on mpc8247?

>No, I better stop here. Please ask your  Freecale  sales  representa-
>tive. He may know better. [Or not, maybe.]
>  
>

The Freescale sales representative we work with actually says that CPM2 
USB host controller is working well.

>Best regards,
>
>Wolfgang Denk
>  
>
-- 
Sincerely yours,
Mike
