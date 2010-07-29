Return-Path: <embedway.test@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id E492FB6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 16:08:57 +1000 (EST)
Received: by gwj22 with SMTP id 22so93706gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Jul 2010 23:08:55 -0700 (PDT)
Date: Thu, 29 Jul 2010 14:08:53 +0800
From: "hacklu" <embedway.test@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: i meet some surprising things,when i modify the dts file
Message-ID: <201007291408499573189@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon673063736764_====="
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon673063736764_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 localbus@f0010100 {
                ....
                ranges = <
                                 0 0 FC000000 1000000   
                                 2 0 FA000000 1000000   
                                 1 0 70000000 1000000
                               >;
                flash@0,0{

.....
}

flash@2,0{

....
}

         board-control@1,0{
                .....
}

}

this is part of my dts files. I don't kown what each field means in the config rangs.
for instance, 2 0 FA000000 1000000 .
I only konw this:
"2" is means chip selects.
"0" is what?
"Fa00000" means the start address.
"1000000" means the range of the device

but ,I got some puzzled.
when I set the two flash in the 0,1 chips select or 0,2 chips select my linux works well.
and, the board-control only can be set at 1 chis select,otherwise the pci doesn't be detected.

so , what is the chips select? is it based on hardware? but my flash can use 0,1,2 chips select.
or it is just set by software? but my pci devece can only work in 1 chips select.


BTW:
I also want to know how to write the dts file. I want to understand each node in the dts files.
but I can't get enough documents. I have readed the linux/document/...
could you privode me some useful information?

thank you ver much~

2010-07-29 



hacklu 

--=====003_Dragon673063736764_=====
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=us-ascii">
<META content="MSHTML 6.00.2900.5969" name=GENERATOR><LINK 
href="BLOCKQUOTE{margin-Top: 0px; margin-Bottom: 0px; margin-Left: 2em}" 
rel=stylesheet></HEAD>
<BODY style="FONT-SIZE: 10pt; MARGIN: 10px; FONT-FAMILY: verdana">
<DIV><FONT face=Verdana size=2>
<DIV>&nbsp;localbus@f0010100&nbsp;{</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;....</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ranges&nbsp;=&nbsp;&lt;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;0&nbsp;FC000000&nbsp;1000000&nbsp;&nbsp; 
</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;0&nbsp;FA000000&nbsp;1000000&nbsp;&nbsp; 
</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;0&nbsp;70000000&nbsp;1000000</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;;</DIV>
<DIV></DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flash@0,0{</DIV>
<DIV style="TEXT-INDENT: 10em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 10em">.....</DIV>
<DIV style="TEXT-INDENT: 10em">}</DIV>
<DIV style="TEXT-INDENT: 10em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 6em">flash@2,0{</DIV>
<DIV style="TEXT-INDENT: 6em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 8em">....</DIV>
<DIV style="TEXT-INDENT: 10em">}</DIV>
<DIV style="TEXT-INDENT: 10em">&nbsp;</DIV></FONT></DIV>
<DIV><FONT face=Verdana 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;board-control@1,0{</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
.....</DIV>
<DIV style="TEXT-INDENT: 8em">}</DIV>
<DIV style="TEXT-INDENT: 8em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">}</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">this is part of my dts files. I don't kown what 
each field means in the config rangs.</DIV>
<DIV style="TEXT-INDENT: 2em">for instance, 
2&nbsp;0&nbsp;FA000000&nbsp;1000000&nbsp;.</DIV>
<DIV style="TEXT-INDENT: 2em">I only konw this:</DIV>
<DIV style="TEXT-INDENT: 4em">"2" is means chip selects.</DIV>
<DIV style="TEXT-INDENT: 4em">"0" is what?</DIV>
<DIV style="TEXT-INDENT: 4em">"Fa00000" means the start address.</DIV>
<DIV style="TEXT-INDENT: 4em">"1000000" means the range of the device</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">but ,I got some puzzled.</DIV>
<DIV style="TEXT-INDENT: 4em">when I set the two flash in the 0,1 chips select 
or 0,2 chips select my linux works well.</DIV>
<DIV style="TEXT-INDENT: 4em">and, the board-control only can be set at 1 chis 
select,otherwise the pci doesn't be detected.</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">so , what is the chips select? is it based on 
hardware? but my flash can use 0,1,2 chips select.</DIV>
<DIV style="TEXT-INDENT: 4em">or it is just set by software? but my pci devece 
can only work in 1 chips select.</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">BTW:</DIV>
<DIV style="TEXT-INDENT: 4em">I also want to know how to write the dts file. I 
want to understand each node in the dts files.</DIV>
<DIV style="TEXT-INDENT: 4em">but I can't get enough documents. I have readed 
the linux/document/...</DIV>
<DIV style="TEXT-INDENT: 4em">could you privode me some useful 
information?</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 4em">thank you ver much~</DIV>
<DIV style="TEXT-INDENT: 4em">&nbsp;</DIV>
<DIV align=left><FONT face=Verdana color=#c0c0c0 size=2>2010-07-29 
</FONT></DIV><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT face=Verdana color=#c0c0c0 size=2><SPAN>hacklu</SPAN> 
</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon673063736764_=====--
