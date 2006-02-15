Return-Path: <dibacco@inwind.it>
Received: from smtp3.libero.it (smtp3.libero.it [193.70.192.127])
	by ozlabs.org (Postfix) with ESMTP id 79B11679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 07:28:50 +1100 (EST)
Date: Wed, 15 Feb 2006 21:28:46 +0100
Message-Id: <IUQWVY$B006F7B9910C94EEDFBBC88B525DC8D9@libero.it>
Subject: Re: no sys folder under /proc
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "galak" <galak@kernel.crashing.org>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I discovered that "klogd" is not running. This could be a problem. Is it =
mandatorty to run it to see kernel messages? 

Thank you for your help,
bye.

---------- Initial Header -----------

>From      : "Kumar Gala" galak@kernel.crashing.org
To          : "dibacco@inwind.it" dibacco@inwind.it
Cc          : 
Date      : Wed, 15 Feb 2006 12:39:12 -0600 (CST)
Subject : Re: no sys folder under /proc







> On Wed, 15 Feb 2006, dibacco@inwind.it wrote:
> 
> > Syslogd is running and it is logging things like the start of busybox=
 for example. The printk doesn't appear in the "messages" file.
> > 
> 
> Does it appear in dmesg?
> 
> You may need to config syslogd to capture the data.
> 
> - kumar
> 
> 
