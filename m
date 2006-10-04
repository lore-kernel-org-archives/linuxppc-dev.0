Return-Path: <pradeepsampath@yahoo.com>
Received: from web83207.mail.mud.yahoo.com (web83207.mail.mud.yahoo.com
	[216.252.101.63]) by ozlabs.org (Postfix) with SMTP id E910F67DF1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Oct 2006 02:35:19 +1000 (EST)
Message-ID: <20061004163517.17874.qmail@web83207.mail.mud.yahoo.com>
Date: Wed, 4 Oct 2006 09:35:17 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
To: Ming Liu <eemingliu@hotmail.com>, ammubhai@gmail.com
In-Reply-To: <BAY110-F79748D36D754E6D6B2A99B21D0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-144517790-1159979717=:17197"
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

--0-144517790-1159979717=:17197
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Ameet/Ming,
   
  First of all really appreciate your inputs on this... 
  Problem 1 :
  I was using the factory shipped compact flash as is which comes with a DOS FAT16 partition and a linux 83 partition with ext3 filesystem. I tried it on 2 factory shipped CFs and its the same behavior - . When i plug-in the CF card reader to the linux box it always reads it as "sda" and in the linux2.6.17.1/Documentation/devices.txt - sda is the device file for SCSI disk devices. Wonerding how you guys configured the root option as "/dev/xsa".
   
  Now i re-formatted my CF, created a ext2 filesystem using busybox-1.1.0 like the BYU instructions. Created 2 partitions on CF card 1. FAT16 partition & 2. linux partition and then created 1. dos file system using mkdosfs and 2. linux ext2 filesystem using mke2fs.
   
  But the problem still persists and i get "Please append a correct "root=" boot option :"
  :(
   
  Problem 2: After i included the TEMAC driver and sysace drivers, the kernel just hangs. I thought i'll fix problem 1 before i get to problem 2... 
   
  With your help i am getting the confidence that i can make this all work!
  thanks once again.
  -Pradeep



Ming Liu <eemingliu@hotmail.com> wrote:
  Hello Ameet,
I am using that driver very well now. There is only one problem. It seems 
that the driver for TEMAC only support Gigabit Enet, not 10/100/1000M 
adapted. But because I want to use the Gigabit enet, I don't care that. So 
it's OK, at lease for 1Gbit/s.

So I don't think Pradeep's problem is caused by Temac. I still suspect that 
he didn't pass a right parameter to "root=", just like what I posted 
before.

Regards
Ming


>From: Ameet Patil 
>To: Ming Liu 
>CC: pradeepsampath@yahoo.com, linuxppc-embedded@ozlabs.org
>Subject: Re: booting 2.6 kernel on ML403
>Date: Wed, 04 Oct 2006 09:35:07 +0100
>
>Ming Liu wrote:
> > Hi,
> >
> >> [ 3.093694] TCP bic registered
> >> [ 3.129458] NET: Registered protocol family 8
> >> [ 3.181412] NET: Registered protocol family 20
> >> [ 3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)
> >> [ 3.313092] Please append a correct "root=" boot option
> >
> > It looks that some errors still exist in the parameters you passed to
> > "root=". Please double check it, or post it in the maillist for deep
> > analysis.
> > Regards
> > Ming
> >
> > _________________________________________________________________
> > 享用世界上最大的电子邮件系统— MSN Hotmail。 http://www.hotmail.com
> > 
------------------------------------------------------------------------
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>Hi Ming,
>IIRC, you are or were using the TEMAC driver along with my System Ace
>driver, isn't it? Does my driver patch ***-after-TEMAC.patch work for
>you? I ask this because Pradeep is having some problems using it (see
>Problem 2 in his email). Could you please update on this?
>
>Thanks,
>-Ameet

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/cn 

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--0-144517790-1159979717=:17197
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hello Ameet/Ming,</DIV>  <DIV>&nbsp;</DIV>  <DIV>First of all really appreciate your inputs on this... </DIV>  <DIV>Problem 1 :</DIV>  <DIV>I was using the factory shipped compact flash as is which comes with a DOS FAT16 partition and a linux 83 partition with ext3 filesystem. I&nbsp;tried it on 2&nbsp;factory shipped CFs and its&nbsp;the same behavior - . When i plug-in the CF card reader to the linux box it always reads it as "sda" and in the linux2.6.17.1/Documentation/devices.txt - sda is the device file for SCSI disk devices. Wonerding how you guys configured the root option as "/dev/xsa".</DIV>  <DIV>&nbsp;</DIV>  <DIV>Now i re-formatted my CF, created a ext2 filesystem using busybox-1.1.0 like the BYU instructions. Created 2 partitions on CF card 1. FAT16 partition &amp; 2. linux partition and then created 1. dos file system using mkdosfs and 2. linux ext2 filesystem using mke2fs.</DIV>  <DIV>&nbsp;</DIV>  <DIV>But the problem still persists and i get "Please
 append a correct "root=" boot option :"</DIV>  <DIV>:(</DIV>  <DIV>&nbsp;</DIV>  <DIV>Problem 2: After i included the TEMAC driver and sysace drivers, the&nbsp;kernel just hangs. I thought i'll fix problem 1 before i get to problem 2... </DIV>  <DIV>&nbsp;</DIV>  <DIV>With your help i am getting the confidence that i can make this all work!</DIV>  <DIV>thanks once again.</DIV>  <DIV>-Pradeep<BR><BR><BR><BR><B><I>Ming Liu &lt;eemingliu@hotmail.com&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello Ameet,<BR>I am using that driver very well now. There is only one problem. It seems <BR>that the driver for TEMAC only support Gigabit Enet, not 10/100/1000M <BR>adapted. But because I want to use the Gigabit enet, I don't care that. So <BR>it's OK, at lease for 1Gbit/s.<BR><BR>So I don't think Pradeep's problem is caused by Temac. I still suspect that <BR>he didn't pass a right parameter to "root=",
 just like what I posted <BR>before.<BR><BR>Regards<BR>Ming<BR><BR><BR>&gt;From: Ameet Patil <AMMUBHAI@GMAIL.COM><BR>&gt;To: Ming Liu <EEMINGLIU@HOTMAIL.COM><BR>&gt;CC: pradeepsampath@yahoo.com, linuxppc-embedded@ozlabs.org<BR>&gt;Subject: Re: booting 2.6 kernel on ML403<BR>&gt;Date: Wed, 04 Oct 2006 09:35:07 +0100<BR>&gt;<BR>&gt;Ming Liu wrote:<BR>&gt; &gt; Hi,<BR>&gt; &gt;<BR>&gt; &gt;&gt; [ 3.093694] TCP bic registered<BR>&gt; &gt;&gt; [ 3.129458] NET: Registered protocol family 8<BR>&gt; &gt;&gt; [ 3.181412] NET: Registered protocol family 20<BR>&gt; &gt;&gt; [ 3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)<BR>&gt; &gt;&gt; [ 3.313092] Please append a correct "root=" boot option<BR>&gt; &gt;<BR>&gt; &gt; It looks that some errors still exist in the parameters you passed to<BR>&gt; &gt; "root=". Please double check it, or post it in the maillist for deep<BR>&gt; &gt; analysis.<BR>&gt; &gt; Regards<BR>&gt; &gt; Ming<BR>&gt; &gt;<BR>&gt; &gt;
 _________________________________________________________________<BR>&gt; &gt; 享用世界上最大的电子邮件系统— MSN Hotmail。 http://www.hotmail.com<BR>&gt; &gt; <BR>------------------------------------------------------------------------<BR>&gt; &gt;<BR>&gt; &gt; _______________________________________________<BR>&gt; &gt; Linuxppc-embedded mailing list<BR>&gt; &gt; Linuxppc-embedded@ozlabs.org<BR>&gt; &gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR>&gt;Hi Ming,<BR>&gt;IIRC, you are or were using the TEMAC driver along with my System Ace<BR>&gt;driver, isn't it? Does my driver patch ***-after-TEMAC.patch work for<BR>&gt;you? I ask this because Pradeep is having some problems using it (see<BR>&gt;Problem 2 in his email). Could you please update on this?<BR>&gt;<BR>&gt;Thanks,<BR>&gt;-Ameet<BR><BR>_________________________________________________________________<BR>与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/cn
 <BR><BR>_______________________________________________<BR>Linuxppc-embedded mailing list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</BLOCKQUOTE><BR>
--0-144517790-1159979717=:17197--
