Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 06BE6DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 19:26:05 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D13FD8780E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 02:25:54 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id A19628780C0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 02:25:54 -0700 (PDT)
Message-ID: <4697451E.3030409@gmail.com>
Date: Fri, 13 Jul 2007 14:55:50 +0530
From: urwithsudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: XSysAce driver cant mount DOS part
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
Content-Type: multipart/alternative;
	boundary="------------020604020904040006050309"
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

This is a multi-part message in MIME format.
--------------020604020904040006050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Robertson, Joseph M. wrote:
>
> Hi all,
>
> I've been workig with this for a while but have made no progress.
> Today I got the latest XSysAce patch for kernel 2.6.17.1 and applied 
> it to get clean code. 
> I inherited the previous code from another developer.
>
Can you send the link to xsysace driver source code from where you obtained.


Thanks
Sudheer


>
> My problem is that mounting the DOS partition always fails in a short 
> time with a kernel oops.
>
> ECAU-9999:# Oops: kernel access of bad area, sig: 11 
> [#1]                      
> PREEMPT                                                                        
> NIP: C00701C8 LR: C0070C18 CTR: 
> 00000000                                       
> REGS: c0391dd0 TRAP: 0300   Not tainted  
> (2.6.17.1)                            
> MSR: 00021030 <ME,IR,DR>  CR: 22028082  XER: 
> 0000000B                          
> DAR: 00000000, DSISR: 
> 00800000                                                 
> TASK = c0373030[4] 'events/0' THREAD: 
> c0390000                                 
> GPR00: 00000080 C0391E80 C0373030 C02CAC00 C0E03000 C0E03154 00000000 
> C02CAC00 
> GPR08: 00200200 00000000 00100100 00000000 00051A4B FFFFDE60 03BD4900 
> 007FFF3B 
> GPR16: 00400000 00000001 FFFFFFFF 03BCDC58 00000000 007FFF00 00000002 
> C0280000 
> GPR24: C0363A10 0000000B 00000000 00000000 00000000 C02CAC00 C035ED20 
> C0E03000 
> NIP [C00701C8] 
> free_block+0x8c/0x138                                           
> LR [C0070C18] 
> drain_array+0xb8/0x124                                           
> Call Trace:                                  
>
> The setup:
> My own build system.
> Kernel 2.6.17.1 with lots of xilinx stuff, eth, i2c, xsysace.  
> Crosscompiled for PPC405.
> Latest, clean XSysAce code.  mods:  major hardcoded to = 125.  Polled 
> mode.
> CF:  3 partitions,
> 1:  DOS FAT16
> 2:  Ext2  main
> 3:  Ext2  rescue
>
> This build boots up fine, mounts a ext2 as root fine.  I can also 
> mount the rescue partition with no problems.
>
> Does anyone have any pointers of where I should look for problems?
>
> My next step is to go and set it up for interrupt service and see if 
> that changes anything.
>
> Thanks,
>
> Joe Robertson
> Joseph.Robertson@sanmina-sci.com
>
>
> CONFIDENTIALITY
> This e-mail message and any attachments thereto, is intended only for 
> use by the addressee(s) named herein and may contain legally 
> privileged and/or confidential information. If you are not the 
> intended recipient of this e-mail message, you are hereby notified 
> that any dissemination, distribution or copying of this e-mail 
> message, and any attachments thereto, is strictly prohibited. If you 
> have received this e-mail message in error, please immediately notify 
> the sender and permanently delete the original and any copies of this 
> email and any prints thereof.
> ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL 
> IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the 
> Uniform Electronic Transactions Act or the applicability of any other 
> law of similar substance and effect, absent an express statement to 
> the contrary hereinabove, this e-mail message its contents, and any 
> attachments hereto are not intended to represent an offer or 
> acceptance to enter into a contract and are not otherwise intended to 
> bind the sender, Sanmina-SCI Corporation (or any of its subsidiaries), 
> or any other person or entity.
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--------------020604020904040006050309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi<br>
<br>
Robertson, Joseph M. wrote:
<blockquote
 cite="mid939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator"
 content="MS Exchange Server version 6.5.7652.24">
  <title>XSysAce driver cant mount DOS part</title>
<!-- Converted from text/plain format -->
  <p><font size="2">Hi all,<br>
  <br>
I've been workig with this for a while but have made no progress.<br>
Today I got the latest XSysAce patch for kernel 2.6.17.1 and applied it
to get clean code.&nbsp;<br>
I inherited the previous code from another developer.<br>
  </font></p>
</blockquote>
Can you send the link to xsysace driver source code from where you
obtained.<br>
<br>
<br>
Thanks<br>
Sudheer<br>
<br>
<br>
<blockquote
 cite="mid939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp"
 type="cite">
  <p><font size="2"><br>
My problem is that mounting the DOS partition always fails in a short
time with a kernel oops.<br>
  <br>
ECAU-9999:# Oops: kernel access of bad area, sig: 11
[#1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
PREEMPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
NIP: C00701C8 LR: C0070C18 CTR:
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
REGS: c0391dd0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;
(2.6.17.1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 22028082&nbsp; XER:
0000000B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
DAR: 00000000, DSISR:
00800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
TASK = c0373030[4] 'events/0' THREAD:
c0390000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
GPR00: 00000080 C0391E80 C0373030 C02CAC00 C0E03000 C0E03154 00000000
C02CAC00&nbsp;<br>
GPR08: 00200200 00000000 00100100 00000000 00051A4B FFFFDE60 03BD4900
007FFF3B&nbsp;<br>
GPR16: 00400000 00000001 FFFFFFFF 03BCDC58 00000000 007FFF00 00000002
C0280000&nbsp;<br>
GPR24: C0363A10 0000000B 00000000 00000000 00000000 C02CAC00 C035ED20
C0E03000&nbsp;<br>
NIP [C00701C8]
free_block+0x8c/0x138&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
LR [C0070C18]
drain_array+0xb8/0x124&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
Call Trace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
  <br>
The setup:<br>
My own build system.<br>
Kernel 2.6.17.1 with lots of xilinx stuff, eth, i2c, xsysace.&nbsp;
Crosscompiled for PPC405.<br>
Latest, clean XSysAce code.&nbsp; mods:&nbsp; major hardcoded to = 125.&nbsp; Polled
mode.<br>
CF:&nbsp; 3 partitions,<br>
1:&nbsp; DOS FAT16<br>
2:&nbsp; Ext2&nbsp; main<br>
3:&nbsp; Ext2&nbsp; rescue<br>
  <br>
This build boots up fine, mounts a ext2 as root fine.&nbsp; I can also mount
the rescue partition with no problems.<br>
  <br>
Does anyone have any pointers of where I should look for problems?<br>
  <br>
My next step is to go and set it up for interrupt service and see if
that changes anything.<br>
  <br>
Thanks,<br>
  <br>
Joe Robertson<br>
<a class="moz-txt-link-abbreviated" href="mailto:Joseph.Robertson@sanmina-sci.com">Joseph.Robertson@sanmina-sci.com</a><br>
  <br>
  </font>
  </p>
  <br>
CONFIDENTIALITY<br>
This e-mail message and any attachments thereto, is intended only for
use by the addressee(s) named herein and may contain legally privileged
and/or confidential information. If you are not the intended recipient
of this e-mail message, you are hereby notified that any dissemination,
distribution or copying of this e-mail message, and any attachments
thereto, is strictly prohibited. If you have received this e-mail
message in error, please immediately notify the sender and permanently
delete the original and any copies of this email and any prints thereof.<br>
ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL IS
NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the Uniform
Electronic Transactions Act or the applicability of any other law of
similar substance and effect, absent an express statement to the
contrary hereinabove, this e-mail message its contents, and any
attachments hereto are not intended to represent an offer or acceptance
to enter into a contract and are not otherwise intended to bind the
sender, Sanmina-SCI Corporation (or any of its subsidiaries), or any
other person or entity.<br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
</body>
</html>

--------------020604020904040006050309--
