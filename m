Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc1-s12.bay0.hotmail.com (bay0-omc1-s12.bay0.hotmail.com
	[65.54.246.84]) by ozlabs.org (Postfix) with ESMTP id 24F58DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 20:40:50 +1000 (EST)
Message-ID: <BAY122-F17AC13F9942DC50628B067CAE50@phx.gbl>
In-Reply-To: <380-220078167042554@M2W021.mail2web.com>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: My kernel hangs after transferring control to linux
Date: Mon, 06 Aug 2007 12:40:45 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Ramesh wrote on Mon, 6 Aug 2007 03:00:42 -0400
>
>Hi ,
>       My kernel hangs after transferring control to linux ,can any one 
>help
>me out how to trace my problem .
>
>I have attached my u-boot.bin and memory layout of our board.
>
>I guess problem will be on the u-boot configuration i am missing something
>.Can any one tell me what todo next because i am getting struck with it for
>more than 2 weeks.I have attached the snap-shot of my problem.If anyone
>has faced similar issue can help me out. I have attached my bin file also
>for your refference.
>
>Regards
>Ramesh
>
Is the console parameter given to the kernel at boot time?
I had the same problem long time ago and it was solved giving the 
console=ttyPSC0,115200 parameter in bootargs. You will need to give the 
appropriate parameter depending on your hardware, of course.

Regards,
Pedro.
>--------------------------------------------------------------------
>mail2web.com – What can On Demand Business Solutions do for you?
>http://link.mail2web.com/Business/SharePoint
>


><< Memory >>


><< U-2.png >>


><< U-1.png >>


>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
Horóscopo, tarot, numerología... Escucha lo que te dicen los astros. 
http://astrocentro.msn.es/
