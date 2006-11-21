Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A8D3567C70
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 23:08:25 +1100 (EST)
Message-ID: <4562EC2B.9090508@varma-el.com>
Date: Tue, 21 Nov 2006 15:08:11 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Stephen Yee <stonepine@126.com>
Subject: Re: FYI:  SM5xx toolchain project berliOS registration
References: <452D0172.1010806@varma-el.com> <4561F9F2.8020706@126.com>
In-Reply-To: <4561F9F2.8020706@126.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sm5xx-devel@lists.berlios.de, Stephen Yee <shyi@bmrtech.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Stephen,

Stephen Yee wrote:
> Hi All,
>  I want to make Voyager GX PCI Demo Board Ver.A(a PCI cards with
> SiliconMotion SM501 chip) work on PPC 405ep board to support CRT
> monitor, I have ported Andrey Volkov's SiliconMotion SM501 drivers to
> 2.6.17,  and I have modified the module parameter 'active_plane' to CRT,
> but, I can't get anything from the CRT monitor, and the relative console
> messages as following:
It is not sufficient, I'm sorry, but driver is not in production stage.

sm5xx_fb_default_var, module_param(active_plane, int, ....) (at the
bottom of sm5xx_fb.c) must be correct too.

Default/active plane(s) must be, certainly, selected by driver
parameter, but...

> 
> ....
> registered sm5xx-fb device
> sm5xx_fb_enable_controller: Enabling CRT controller
> Console: switching to colour frame buffer device 128x48
> fb0: SM5xx CRT frame buffer device
> .....
> 
> is Here a  successful  story  about using SM501 on PPC platform with
> this driver?  and would you please give me some advices to drive this
> devices?
Properly speaking, we are use SM5xx on our MPC5200 based board.
So this driver, by definition, working on PPC ;).
AFAIK, only one problem exist in kernel FB: it is 16bpp (AKA RGB565).
(in DirectFB and in X such problem worked around)

P.S. Stephen, as I pointed in my mail, which you are quote,
sm5xx-devel@lists.berlios.de is working, so, please, CC such mails
in this list too.

--
Andrey Volkov


> Thanks in Advance.
> Stephen.
> 
> Andrey Volkov wrote:
> 
>> Hi all,
>>
>> Yesterday I issued new SiliconMotion SM501 drivers
>> project request to berlios, and receive
>> approvement couple hours ago.
>>
>> So project home page is:
>>
>> http://developer.berlios.de/projects/sm5xx/
>>
>> Anyone who wants admin/write-access, please register with
>> berlios and tell me your account.
>>
>> SVN will be activated in nearest hours.
>> Berlios has direct shell access to your repos.
>> So if there are any svn/CVS-dumps to import or any
>> scripts to set up...
>>
>> The central mailing list
>>
>>     sm5xx-devel@lists.berlios.de
>>
>> will be active soon too.
>>
>> -- 
>> Happy hacking ;),
>>
>> Andrey Volkov
>> Varma Electronics Oy
>>
>> -------- Original Message --------
>> Subject: BerliOS Developer Project Approved
>> Date: Wed, 11 Oct 2006 12:49:58 +0200 (CEST)
>> From: admin@berlios.de
>> To: avolkov@varma-el.com
>>
>> Your project registration for BerliOS Developer has been approved.
>>
>> Project Full Name:  SM5xx Toolchain
>> Project Unix Name:  sm5xx
>> CVS Server:         cvs.berlios.de
>> SVN Server:         svn.berlios.de
>> Shell Server:       shell.berlios.de
>> Web Server:         sm5xx.berlios.de
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>>  
>>
> 
> 
> 
> 
