Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4E9402BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 22:52:29 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Sep 2004 08:23:05 EDT."
	<Pine.LNX.4.60.0409210808250.9449@dell.enoriver.com>
Date: Tue, 21 Sep 2004 14:52:22 +0200
Sender: wd@denx.de
Message-Id: <20040921125227.46AE2C108D@atlas.denx.de>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409210808250.9449@dell.enoriver.com> you wrote:
> 
> from list discussions some time back, i already gave up on the idea of 
> the configuration being able to detect the exact processor and taking 
> that into account.  we've already established that, and i'm happy with 
> that.

OK.

> all i'm suggesting now is a drop down choice menu of known patches 
> relevant to that architecture, that's all.  in some cases, there would 
> be two choices, as in:
> 
>  	[ ] I2C/SPI for 850
>   	[ ] I2C/SPI for 8xx (non-850)

Plus there is also the case of "need to relocate parameter RAM  on  a
MPC852/859/866/...  processor".  In  this  case  no microcode patch i
sneeded, and the current code will crash the system.

More cases may be necessary.

> i can't imagine that this list would get overly long.  from what i can 
> see, the denx tree supports the following list of patches:

Please forget this. I asked you several times NOT  to  use  this  old
code  for  reference.  It  is  known to be broken in several configu-
rations.

> and, unless i'm reading this badly, that's the entire list.  all of 

No, it's  not.  It  will  not  work  on  most  of  the  newer  MPC8xx
processors.

> so ... why is this such an objectionable thing?

Because it is (1) incomplete and (2) broken.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are two ways to write error-free programs. Only the  third  one
works.
