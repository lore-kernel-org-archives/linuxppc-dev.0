Return-Path: <paravpandit@yahoo.com>
Received: from web36606.mail.mud.yahoo.com (web36606.mail.mud.yahoo.com
	[209.191.85.23]) by ozlabs.org (Postfix) with SMTP id 0A165DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Dec 2006 18:05:32 +1100 (EST)
Date: Wed, 20 Dec 2006 23:05:28 -0800 (PST)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Re: Define Linux system memory
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	Clint Thomas <cthomas@Soneticom.com>
In-Reply-To: <458A2289.4070401@dlasys.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-228382367-1166684728=:74305"
Message-ID: <588266.74305.qm@web36606.mail.mud.yahoo.com>
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

--0-228382367-1166684728=:74305
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  This memory information is passed by the u-boot in bd_info structure (typedef to bd_t).
  Its defined in include/asm-ppc/ppcboot.h file.
  First two parameters specify the start address and length.
   
  Well, I'll at least try on my host x86 system. There is doesn't get from the grub.
  It should work and I should be able to see in cat /proc/meminfo.
  I'll try and let you know.
   
  Regards,
  Parav Pandit
  

"David H. Lynch Jr." <dhlii@dlasys.net> wrote:
  Clint Thomas wrote:       To anybody who has done this before or understands how to do this, I was wondering if you know how to "tell" the kernel how much memory there is in the system. An example would be if I have 512MB of RAM, but only want the system to know that there is about 500MB in RAM, so that 12MB does not exist to the OS/kernel. Would this require mucking about in U-boot? or can I just define this in the kernel source? Thanks
   
   Clinton Thomas

    Most bootloaders including u-boot pass a board information structure that includes a variety of information including the memory size.
    Also I think top of memory is also typically passed to the Linux Kernel as a register parameter  by the boot loader.



     


---------------------------------
  _______________________________________________  Linuxppc-embedded mailing list  Linuxppc-embedded@ozlabs.org  https://ozlabs.org/mailman/listinfo/linuxppc-embedded



--   Dave Lynch             DLA Systems  Software Development:               Embedded Linux  717.627.3770         dhlii@dlasys.net    http://www.dlasys.net  fax: 1.253.369.9244               Cell: 1.717.587.7774  Over 25 years' experience in platforms, languages, and technologies too numerous to list.    "Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."  Albert Einstein  
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-228382367-1166684728=:74305
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>This memory information is passed by the u-boot in bd_info structure (typedef to bd_t).</div>  <div>Its defined in include/asm-ppc/ppcboot.h file.</div>  <div>First two parameters specify the start address and length.</div>  <div>&nbsp;</div>  <div>Well, I'll at least try on my host x86 system. There is doesn't get from the grub.</div>  <div>It should work and I should be able to see in cat /proc/meminfo.</div>  <div>I'll try and let you know.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div><BR><BR><B><I>"David H. Lynch Jr." &lt;dhlii@dlasys.net&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Clint Thomas wrote:   <BLOCKQUOTE cite=mid:3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local type="cite">  <META content="MSHTML 6.00.5730.11" name=GENERATOR>  <DIV><SPAN class=346164916-20122006><FONT face=Arial size=2>To
 anybody who has done this before or understands how to do this, I was wondering if you know how to "<STRONG>tell</STRONG>" the kernel how much memory there is in the system. An example would be if I have 512MB of RAM, but only want the system to know that there is about 500MB in RAM, so that 12MB does not exist to the OS/kernel. Would this require mucking about in U-boot? or can I just define this in the kernel source? Thanks</FONT></SPAN></DIV>  <DIV>&nbsp;</DIV>  <DIV align=left><FONT face=Arial size=2>&nbsp;Clinton Thomas</FONT></DIV></BLOCKQUOTE><BR>&nbsp;&nbsp;&nbsp; Most bootloaders including u-boot pass a board information structure that includes a variety of information including the memory size.<BR>&nbsp;&nbsp;&nbsp; Also I think top of memory is also typically passed to the Linux Kernel as a register parameter&nbsp; by the boot loader.<BR><BR><BR><BR>  <BLOCKQUOTE cite=mid:3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local type="cite"> 
 <DIV>&nbsp;</DIV><PRE wrap=""><HR width="90%" SIZE=4>  _______________________________________________  Linuxppc-embedded mailing list  <A class=moz-txt-link-abbreviated href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A>  <A class=moz-txt-link-freetext href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></PRE></BLOCKQUOTE><BR><BR><PRE class=moz-signature cols="72">--   Dave Lynch             DLA Systems  Software Development:               Embedded Linux  717.627.3770         <A class=moz-txt-link-abbreviated href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</A>    <A class=moz-txt-link-freetext href="http://www.dlasys.net/">http://www.dlasys.net</A>  fax: 1.253.369.9244               Cell: 1.717.587.7774  Over 25 years' experience in platforms, languages, and technologies too numerous to list.    "Any intelligent fool can make things bigger and more complex... It takes a touch of
 genius - and a lot of courage to move in the opposite direction."  Albert Einstein  </PRE>_______________________________________________<BR>Linuxppc-embedded mailing list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</BLOCKQUOTE><BR><p> __________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com <p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-228382367-1166684728=:74305--
