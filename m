Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 965566820D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 00:15:47 +1000 (EST)
Message-ID: <4315BB7E.2030604@anagramm.de>
Date: Wed, 31 Aug 2005 16:15:26 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: JohnsonCheng <JohnsonCheng@qnap.com.tw>
References: <20050831090821.4D4ED681F2@ozlabs.org>
In-Reply-To: <20050831090821.4D4ED681F2@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Did anybody use netatalk on ppc??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Johnson!

Advice?
This is the wrong list for questions like this, I guess.

However we run netatalk also on our systems (mostly ix86)
on an utf-8 reiserfs filesystem and we used convmv to
solve some character translation issues to/from non-utf-8
filesystems.
You might want to check with google and the netatalk
lists.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

JohnsonCheng wrote:
> Dear All,
> 
>  
> 
> I have used netatalk2.0.3 with Unicode on x86, it's no problem.
> 
> Then I port it to ppc board, compiler is OK and also can running.
> 
> Unfortunately, I have trouble on Unicode issue, I found it doesn't work.
> 
> Does someone give me some advice??
> 
>  
> 
>  
> 
> Thanks,
> 
> Johnson Cheng
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
