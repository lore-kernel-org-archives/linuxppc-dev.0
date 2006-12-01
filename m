Return-Path: <pradeepsampath@yahoo.com>
Received: from web83407.mail.sp1.yahoo.com (web83407.mail.sp1.yahoo.com
	[69.147.64.55]) by ozlabs.org (Postfix) with SMTP id D397967B99
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 12:16:49 +1100 (EST)
Date: Thu, 30 Nov 2006 17:10:08 -0800 (PST)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: RE : Some questions about the Xilinx Temac driver.
To: 'Ming Liu' <eemingliu@hotmail.com>
In-Reply-To: <000b01c714a3$07330f40$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1750135780-1164935408=:88813"
Message-ID: <839098.88813.qm@web83407.mail.sp1.yahoo.com>
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

--0-1750135780-1164935408=:88813
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ming,
   
  See previous postings from Robert Corley. 
   
  Pradeep

alayrac <christophe.alayrac@cresitt.com> wrote:
  Hi Ming

You will find informations to build linux 2.6 BSP in the file
EDK_8.2\sw\ThirdParty\bsp\linux_2_6_v1_00_a\doc\linux_2_6_v1_00_a.pdf 

This file is installed with plateform Studio

Regards

Chris

CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com 
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De : linuxppc-embedded-
<----> bounces+christophe.alayrac=cresitt.com@ozlabs.org [mailto:linuxppc-
<----> embedded-bounces+christophe.alayrac=cresitt.com@ozlabs.org] De la
<----> part de Ming Liu
<----> Envoyé : jeudi 30 novembre 2006 17:37
<----> À : mgalassi@c-cor.com
<----> Cc : linuxppc-embedded@ozlabs.org
<----> Objet : Re: Some questions about the Xilinx Temac driver.
<----> 
<----> Dear Michael,
<----> Now I update my Xilinx design software from 8.1 to 8.2 and notice
<----> that
<----> there is already linux_2_6 support. Then I generated the BSP for
<----> linux 2.6.
<----> I found that there are some differences from the older version, e.g.
<----> there
<----> are some files such as XMakefile, xps_connected.cud, etc. I am
<----> confused
<----> with this. So could you please give me a hand on how to use such a
<----> generated BSP to build my linux 2.6 kernel? I cannot find any
<----> guidance on
<----> how to do that. Thanks for your help.
<----> 
<----> BR
<----> Ming
<----> 
<----> 
<----> >From: Michael Galassi 
<----> >Reply-To: Michael Galassi 
<----> >To: "Ming Liu" 
<----> >CC: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
<----> >Subject: Re: Some questions about the Xilinx Temac driver.
<----> >Date: Wed, 29 Nov 2006 08:38:37 -0800
<----> >
<----> >If you use the latest xilinx ISE/EDK/IP update and let it overlay
<----> your
<----> >mvl source tree with it's files it shouldn't take you more than a
<----> few
<----> >hours to patch things up to where you can compile a kernel which
<----> will
<----> >work on the 3.00b IP. The PHY support is useless but you can work
<----> >around that easily enough. I've not tried to get any of that
<----> working
<----> >with a semi-current kernel so if you're not using mvl's flavor of
<----> 2.6.10
<----> >you may run into other issues.
<----> >
<----> >-michael
<----> >
<----> > >Dear Andrei,
<----> > >I have some questions about your xilinx Temac driver. If possible,
<----> please
<----> > >give me a hand on such confusing problems.
<----> > >
<----> > >1. I am using the driver from
<----> > >http://source.mvista.com/~ank/paulus-powerpc/20060309/, and the IP
<----> cores
<----> of
<----> > >plb_temac and hard_temac whose hardware versions are 2.00a and
<----> 1.00a
<----> > >specifically. I know the newest versions of those hardwares are
<----> 3.00a
<----> and
<----> > >3.00a. Is your driver support the 3.00a version hardware? Also, is
<----> the
<----> > >driver from http://source.mvista.com/~ank/paulus-powerpc/20060309/
<----> the
<----> > >latest one for Xilinx Temac? If you have some updated version,
<----> please
<----> tell
<----> > >me the address.
<----> > >
<----> > >2. Is that driver from the above address able to support SGDMA? In
<----> fact,
<----> I
<----> > >am testing the throughput of the Temac enet by my own little
<----> program
<----> which
<----> > >is very simple. In the program running on the board, the pseudo
<----> code
<----> looks
<----> > >just like this:
<----> > > for(;;){
<----> > > select();
<----> > > if(FD_ISSET()){
<----> > > recvfrom();
<----> > > }
<----> > >
<----> > > sendto();
<----> > > }
<----> > >
<----> > >The program is just to receive packets from a pc and then transfer
<----> them
<----> > >back. But in this condition, the embedded PowerPC CPU is easily
<----> used by
<----> > >100&. So I suspect that maybe the DMA is not running properly.
<----> Could you
<----> > >please say something about the DMA in your driver?
<----> > >
<----> > >Thanks a lot for your telling.
<----> > >
<----> > >Regards
<----> > >Ming
<----> > >
<----> > >_________________________________________________________________
<----> > >免费下载 MSN Explorer: http://explorer.msn.com/lccn/
<----> > >
<----> > >
<----> > >--===============1695844909==
<----> > >Content-Type: text/plain; charset="us-ascii"
<----> > >MIME-Version: 1.0
<----> > >Content-Transfer-Encoding: 7bit
<----> > >Content-Disposition: inline
<----> > >
<----> > >_______________________________________________
<----> > >Linuxppc-embedded mailing list
<----> > >Linuxppc-embedded@ozlabs.org
<----> > >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
<----> > >--===============1695844909==--
<----> 
<----> _________________________________________________________________
<----> 与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/cn


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--0-1750135780-1164935408=:88813
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Ming,</div>  <div>&nbsp;</div>  <div>See previous postings from Robert Corley. </div>  <div>&nbsp;</div>  <div>Pradeep<BR><BR><B><I>alayrac &lt;christophe.alayrac@cresitt.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Ming<BR><BR>You will find informations to build linux 2.6 BSP in the file<BR>EDK_8.2\sw\ThirdParty\bsp\linux_2_6_v1_00_a\doc\linux_2_6_v1_00_a.pdf <BR><BR>This file is installed with plateform Studio<BR><BR>Regards<BR><BR>Chris<BR><BR>CRESITT INDUSTRIE<BR>12 Rue de Blois, BP6744<BR>45067 ORLEANS Cedex 2<BR>Tel : 02.38.49.45.59<BR>Fax :02.38.49.45.55<BR>Email : christophe.alayrac@cresitt.com <BR>Web : http://www.cresitt.com<BR><BR><BR>&lt;----&gt; -----Message d'origine-----<BR>&lt;----&gt; De : linuxppc-embedded-<BR>&lt;----&gt; bounces+christophe.alayrac=cresitt.com@ozlabs.org [mailto:linuxppc-<BR>&lt;----&gt;
 embedded-bounces+christophe.alayrac=cresitt.com@ozlabs.org] De la<BR>&lt;----&gt; part de Ming Liu<BR>&lt;----&gt; Envoyé : jeudi 30 novembre 2006 17:37<BR>&lt;----&gt; À : mgalassi@c-cor.com<BR>&lt;----&gt; Cc : linuxppc-embedded@ozlabs.org<BR>&lt;----&gt; Objet : Re: Some questions about the Xilinx Temac driver.<BR>&lt;----&gt; <BR>&lt;----&gt; Dear Michael,<BR>&lt;----&gt; Now I update my Xilinx design software from 8.1 to 8.2 and notice<BR>&lt;----&gt; that<BR>&lt;----&gt; there is already linux_2_6 support. Then I generated the BSP for<BR>&lt;----&gt; linux 2.6.<BR>&lt;----&gt; I found that there are some differences from the older version, e.g.<BR>&lt;----&gt; there<BR>&lt;----&gt; are some files such as XMakefile, xps_connected.cud, etc. I am<BR>&lt;----&gt; confused<BR>&lt;----&gt; with this. So could you please give me a hand on how to use such a<BR>&lt;----&gt; generated BSP to build my linux 2.6 kernel? I cannot find any<BR>&lt;----&gt; guidance
 on<BR>&lt;----&gt; how to do that. Thanks for your help.<BR>&lt;----&gt; <BR>&lt;----&gt; BR<BR>&lt;----&gt; Ming<BR>&lt;----&gt; <BR>&lt;----&gt; <BR>&lt;----&gt; &gt;From: Michael Galassi <MGALASSI@C-COR.COM><BR>&lt;----&gt; &gt;Reply-To: Michael Galassi <MGALASSI@C-COR.COM><BR>&lt;----&gt; &gt;To: "Ming Liu" <EEMINGLIU@HOTMAIL.COM><BR>&lt;----&gt; &gt;CC: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org<BR>&lt;----&gt; &gt;Subject: Re: Some questions about the Xilinx Temac driver.<BR>&lt;----&gt; &gt;Date: Wed, 29 Nov 2006 08:38:37 -0800<BR>&lt;----&gt; &gt;<BR>&lt;----&gt; &gt;If you use the latest xilinx ISE/EDK/IP update and let it overlay<BR>&lt;----&gt; your<BR>&lt;----&gt; &gt;mvl source tree with it's files it shouldn't take you more than a<BR>&lt;----&gt; few<BR>&lt;----&gt; &gt;hours to patch things up to where you can compile a kernel which<BR>&lt;----&gt; will<BR>&lt;----&gt; &gt;work on the 3.00b IP. The PHY support is useless but you can
 work<BR>&lt;----&gt; &gt;around that easily enough. I've not tried to get any of that<BR>&lt;----&gt; working<BR>&lt;----&gt; &gt;with a semi-current kernel so if you're not using mvl's flavor of<BR>&lt;----&gt; 2.6.10<BR>&lt;----&gt; &gt;you may run into other issues.<BR>&lt;----&gt; &gt;<BR>&lt;----&gt; &gt;-michael<BR>&lt;----&gt; &gt;<BR>&lt;----&gt; &gt; &gt;Dear Andrei,<BR>&lt;----&gt; &gt; &gt;I have some questions about your xilinx Temac driver. If possible,<BR>&lt;----&gt; please<BR>&lt;----&gt; &gt; &gt;give me a hand on such confusing problems.<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;1. I am using the driver from<BR>&lt;----&gt; &gt; &gt;http://source.mvista.com/~ank/paulus-powerpc/20060309/, and the IP<BR>&lt;----&gt; cores<BR>&lt;----&gt; of<BR>&lt;----&gt; &gt; &gt;plb_temac and hard_temac whose hardware versions are 2.00a and<BR>&lt;----&gt; 1.00a<BR>&lt;----&gt; &gt; &gt;specifically. I know the newest versions of those hardwares
 are<BR>&lt;----&gt; 3.00a<BR>&lt;----&gt; and<BR>&lt;----&gt; &gt; &gt;3.00a. Is your driver support the 3.00a version hardware? Also, is<BR>&lt;----&gt; the<BR>&lt;----&gt; &gt; &gt;driver from http://source.mvista.com/~ank/paulus-powerpc/20060309/<BR>&lt;----&gt; the<BR>&lt;----&gt; &gt; &gt;latest one for Xilinx Temac? If you have some updated version,<BR>&lt;----&gt; please<BR>&lt;----&gt; tell<BR>&lt;----&gt; &gt; &gt;me the address.<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;2. Is that driver from the above address able to support SGDMA? In<BR>&lt;----&gt; fact,<BR>&lt;----&gt; I<BR>&lt;----&gt; &gt; &gt;am testing the throughput of the Temac enet by my own little<BR>&lt;----&gt; program<BR>&lt;----&gt; which<BR>&lt;----&gt; &gt; &gt;is very simple. In the program running on the board, the pseudo<BR>&lt;----&gt; code<BR>&lt;----&gt; looks<BR>&lt;----&gt; &gt; &gt;just like this:<BR>&lt;----&gt; &gt; &gt; for(;;){<BR>&lt;----&gt; &gt; &gt;
 select();<BR>&lt;----&gt; &gt; &gt; if(FD_ISSET()){<BR>&lt;----&gt; &gt; &gt; recvfrom();<BR>&lt;----&gt; &gt; &gt; }<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt; sendto();<BR>&lt;----&gt; &gt; &gt; }<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;The program is just to receive packets from a pc and then transfer<BR>&lt;----&gt; them<BR>&lt;----&gt; &gt; &gt;back. But in this condition, the embedded PowerPC CPU is easily<BR>&lt;----&gt; used by<BR>&lt;----&gt; &gt; &gt;100&amp;. So I suspect that maybe the DMA is not running properly.<BR>&lt;----&gt; Could you<BR>&lt;----&gt; &gt; &gt;please say something about the DMA in your driver?<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;Thanks a lot for your telling.<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;Regards<BR>&lt;----&gt; &gt; &gt;Ming<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;_________________________________________________________________<BR>&lt;----&gt; &gt; &gt;免费下载 MSN
 Explorer: http://explorer.msn.com/lccn/<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;--===============1695844909==<BR>&lt;----&gt; &gt; &gt;Content-Type: text/plain; charset="us-ascii"<BR>&lt;----&gt; &gt; &gt;MIME-Version: 1.0<BR>&lt;----&gt; &gt; &gt;Content-Transfer-Encoding: 7bit<BR>&lt;----&gt; &gt; &gt;Content-Disposition: inline<BR>&lt;----&gt; &gt; &gt;<BR>&lt;----&gt; &gt; &gt;_______________________________________________<BR>&lt;----&gt; &gt; &gt;Linuxppc-embedded mailing list<BR>&lt;----&gt; &gt; &gt;Linuxppc-embedded@ozlabs.org<BR>&lt;----&gt; &gt; &gt;https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR>&lt;----&gt; &gt; &gt;--===============1695844909==--<BR>&lt;----&gt; <BR>&lt;----&gt; _________________________________________________________________<BR>&lt;----&gt; 与联机的朋友进行交流，请使用 MSN Messenger:
 http://messenger.msn.com/cn<BR><BR><BR>_______________________________________________<BR>Linuxppc-embedded mailing list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</BLOCKQUOTE><BR>
--0-1750135780-1164935408=:88813--
