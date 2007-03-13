Return-Path: <ammubhai@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by ozlabs.org (Postfix) with ESMTP id 4BB5BDDECD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 10:41:25 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so2754821mue
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 16:41:23 -0700 (PDT)
Message-ID: <45F736A0.3050806@gmail.com>
Date: Tue, 13 Mar 2007 23:41:20 +0000
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: patel nirav <indianirav@yahoo.com>
Subject: Re: gcc -static
References: <15137.37968.qm@web43146.mail.sp1.yahoo.com>
In-Reply-To: <15137.37968.qm@web43146.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: rtai@rtai.org, linux ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"-static" option tells gcc to generate an executable that will run by itself. All the runtime libraries (eg. glibc) are linked into the application code to form one big executable.

-Ameet


patel nirav wrote:
> Hello all,
> Can any body tell me what is the use of " - static" option for gcc 
> compilation ?
>
>
>
> Nirav J Patel
> M.Tech(CSE),
> Nirma University,
> Ahmedabad-382481.
> 9925138959
>
> ------------------------------------------------------------------------
> Bored stiff? 
> <http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com> Loosen up...
> Download and play hundreds of games for free 
> <http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com> on Yahoo! 
> Games.
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
