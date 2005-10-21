Return-Path: <mguertin@macdiscussion.com>
Received: from mail.brucemaudesign.com (H51.C17.B96.tor.eicat.ca [66.96.17.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 029DB68639
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 05:09:12 +1000 (EST)
In-Reply-To: <wrpek6eeo94.fsf@wild-wind.fr.eu.org>
References: <wrpll0of535.fsf@wild-wind.fr.eu.org>
	<1129869509.6265.32.camel@gaston>
	<wrpek6eeo94.fsf@wild-wind.fr.eu.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6337E791-EB1F-47E5-8518-FE0D83987705@macdiscussion.com>
From: Mark Guertin <mguertin@macdiscussion.com>
Date: Fri, 21 Oct 2005 14:36:02 -0400
To: maz@misterjones.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: v2.6.13.4 : Bad page state at prep_new_page when booting with
	quik
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not sure what quick version you are using, but the guys at  
shiner.info have been hacking on it for a while (including some bug  
fixes) .. so you might want to try out alternate versions if you  
haven't already.

http://shiner.info/?files/Yellow%20Dog%20Linux%204/quik

Mark

On 21-Oct-05, at 2:08 PM, Marc Zyngier wrote:

>>>>>> "BenH" == Benjamin Herrenschmidt <benh@kernel.crashing.org>  
>>>>>> writes:
>>>>>>
>
> BenH> I'd suggest dumping to 8 or so first words of sysctrl_regs  
> and checking
> BenH> what difference is there.
>
> Here you go :
>
> BootX :
>
> *fde69000 = 10000000
> *fde69004 = 00000000
> *fde69008 = 04000000
> *fde6900c = 00000000
> *fde69010 = 04101102
> *fde69014 = 00000000
> *fde69018 = 00000345
> *fde6901c = 00000000
>
> Quik:
>
> *fdeff000 = 10000000
> *fdeff004 = 00000000
> *fdeff008 = 04000000
> *fdeff00c = 00000000
> *fdeff010 = 04101102
> *fdeff014 = 00000000
> *fdeff018 = 00000345
> *fdeff01c = 00000000
>
> Except for the ioremap address being different, not much to see
> here...
>
> BenH> It could be something else tho ... like some problem with
> BenH> quik...
>
> I fear that... But even in such a case ,understanding what confuses
> the kernel would help a lot...
>
> Thanks for your help,
>
>     M.
> -- 
> And if you don't know where you're going, any road will take you  
> there...
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
