Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id AC357687E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 01:39:45 +1100 (EST)
Message-ID: <43847F2E.8050001@ru.mvista.com>
Date: Wed, 23 Nov 2005 17:39:42 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: zengshuai@sogou.com
References: <10059043.1132751565040.JavaMail.postfix@mx3.mail.sohu.com>
In-Reply-To: <10059043.1132751565040.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: about powerpc design,thanks very much
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

zengshuai@sogou.com wrote:
> first,i'm sorry my poor English.
> Our team is a new team.we want to design a production,which used to receive/transmit aal2 and aal5.
> So we choose the MPC8280 and PQ2FADS_ZU(a kind of MPC8280 Boards). Now we can run linux on this board.
> But there are so less example code about ATM,and they don't support linux,but bare-board.
> We are all student.We don't know how to go on our design.Use linux or not,use Codewarrior Development 
> Studio PowerPC ISA Edition for Comm Processors or Linux Application/Platform Edition,can get some code 
> we needed or not,and so on.
> Our freescale agent just sale us a PQ2FADS_ZU board,and say they didn't know any more.
> We need some help and some advise.What are you usually to do next to go on your design? thanks a lot.
> 
There is a sf project - http://mpc8260sar.sourceforge.net/. I don't know if PQ2FADS is
supported, but it supports 8272ADS which is really similar.

For start, take a look at http://www.denx.de/wiki/DULG/Manual.
> ------------------------------
> 我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
> http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

祝好运

-- 
Sincerely,
Vitaly
