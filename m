Message-ID: <3EF9CB72.7030808@esteem.com>
Date: Wed, 25 Jun 2003 09:18:58 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: cedric_aubert@yahoo.fr
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: (Sudo off topic)Simple cheap IDE intrerface for IBM 405
References: <20030625070637.16435.qmail@web41812.mail.yahoo.com>
In-Reply-To: <20030625070637.16435.qmail@web41812.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cedric Aubert wrote:
>>-----Original Message-----
>>From: Chris Zimman
>>Sent: Wednesday, June 25, 2003 8:50 AM
>>Subject: Re: (Sudo off topic)Simple cheap IDE intrerface for IBM 405
>>
>> On Tue, Jun 24, 2003 at 03:17:24PM -0700, Conn Clark wrote:

<snip>

>>controllers from surplus suppliers, either should work fine.
>
>
> Hi
>
> For information, what is the cheap simple IDE interface for the MPC8xx
> that you talk about ?
>
> Thanks
>
> Cedric
>
>
>
>

	There is a way to hook up an IDE interface to the PCMCIA interface of
the Motorola 8xx family of processors. The code for controling it is in
the sourcefile /drivers/ide/ide-m8xx.c . I think that there is more info
on it in the PPCBoot/U-Boot source code.

	Enough people are doing it that it made it in the kernel so there must
be documentation some where.


Hope this helps,


	Conn

--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
