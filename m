Return-Path: <stevan@iritel.com>
Received: from iritel.iritel.bg.ac.yu (iritel.iritel.bg.ac.yu [193.203.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02CB4DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 23:12:54 +1000 (EST)
Received: from iritel (root@localhost)
	by iritel.iritel.bg.ac.yu (8.13.1/8.13.1) with SMTP id l76D7QuA032501
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Aug 2007 15:07:26 +0200
Subject: RE: My kernel hangs after transferring control to linux
From: Stevan Ignjatovic <stevan@iritel.com>
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
In-Reply-To: <BAY122-F17AC13F9942DC50628B067CAE50@phx.gbl>
References: <BAY122-F17AC13F9942DC50628B067CAE50@phx.gbl>
Content-Type: text/plain; charset=utf-8
Date: Mon, 06 Aug 2007 15:11:33 +0200
Message-Id: <1186405893.4866.1.camel@stevan>
Mime-Version: 1.0
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

Maybe this can help...

http://www.denx.de/wiki/view/DULG/LinuxHangsAfterUncompressingKernel

Regards,
Stevan

On Mon, 2007-08-06 at 12:40 +0200, Pedro Luis D. L. wrote:
> 
> Ramesh wrote on Mon, 6 Aug 2007 03:00:42 -0400
> >
> >Hi ,
> >       My kernel hangs after transferring control to linux ,can any one 
> >help
> >me out how to trace my problem .
> >
> >I have attached my u-boot.bin and memory layout of our board.
> >
> >I guess problem will be on the u-boot configuration i am missing something
> >.Can any one tell me what todo next because i am getting struck with it for
> >more than 2 weeks.I have attached the snap-shot of my problem.If anyone
> >has faced similar issue can help me out. I have attached my bin file also
> >for your refference.
> >
> >Regards
> >Ramesh
> >
> Is the console parameter given to the kernel at boot time?
> I had the same problem long time ago and it was solved giving the 
> console=ttyPSC0,115200 parameter in bootargs. You will need to give the 
> appropriate parameter depending on your hardware, of course.
> 
> Regards,
> Pedro.
> >--------------------------------------------------------------------
> >mail2web.com – What can On Demand Business Solutions do for you?
> >http://link.mail2web.com/Business/SharePoint
> >
> 
> 
> ><< Memory >>
> 
> 
> ><< U-2.png >>
> 
> 
> ><< U-1.png >>
> 
> 
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _________________________________________________________________
> Horóscopo, tarot, numerología... Escucha lo que te dicen los astros. 
> http://astrocentro.msn.es/
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
