Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [204.127.192.82])
	by ozlabs.org (Postfix) with ESMTP id 479E4679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 04:13:37 +1000 (EST)
Message-ID: <44B7DEC3.1090308@dlasys.net>
Date: Fri, 14 Jul 2006 14:13:23 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to get individual patches
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>	<20060627212448.7d048b7a@White64>
	<44A23488.7030606@dlasys.net>
	<528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
In-Reply-To: <528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------030004060601000705050503"
Reply-To: dhlii@comcast.net
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
--------------030004060601000705050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Grant Likely wrote:
> On 6/28/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>   
>>     The bsp I am working on works with 2.6.16.21 but fails with 2.6.17.
>>
>>     How can I find the individual patches that make up the transition
>> from 2.6.16.21 to 2.6.17 ?
>>     
>
> Unfortunately, there isn't a direct line between .16.21 and .17 which
> makes it complicated.  Does your bsp work with .16?  If so; you can
> use the 'git bisect' command to figure out exactly where the
> regression occured.
>
> If it doesn't work on .16; you can do a bisect between .16 and .16.21
> to figure out what patch is missing between .16 and .17.
>
> $ git bisect good v2.6.16
> $ git bisect bad           # the head of the tree
> compile, test, etc.
> $ git bisect good|bad    # depends on whether it works or not
> compile, test, etc
> $ git bisect good|bad    # you get the idea... repeat until it's narrowed down
> $ git log                          # see where you are in the git tree.
>
>   
    Thank You git bisect has proven to be incredibly interesting.

    One question/problem - maybe an incomplete understanding of git.
   
    What I need to do is get to some version of 2.6.16 - as they all
work for me.

    cut in my patches.

    And THEN start bisecting while retaining my patches.

    Is that going to work or am I going to have to repatch each time ?

    Basically can I use git to insert a patch into the middle of its
delta history and then advance forward from there ?

    It is rapidly becoming obvious that competence with git could have
big payback.

   

   











-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------030004060601000705050503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Grant Likely wrote:
<blockquote
 cite="mid528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com"
 type="cite">
  <pre wrap="">On 6/28/06, David H. Lynch Jr. <a class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">    The bsp I am working on works with 2.6.16.21 but fails with 2.6.17.

    How can I find the individual patches that make up the transition
from 2.6.16.21 to 2.6.17 ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Unfortunately, there isn't a direct line between .16.21 and .17 which
makes it complicated.  Does your bsp work with .16?  If so; you can
use the 'git bisect' command to figure out exactly where the
regression occured.

If it doesn't work on .16; you can do a bisect between .16 and .16.21
to figure out what patch is missing between .16 and .17.

$ git bisect good v2.6.16
$ git bisect bad           # the head of the tree
compile, test, etc.
$ git bisect good|bad    # depends on whether it works or not
compile, test, etc
$ git bisect good|bad    # you get the idea... repeat until it's narrowed down
$ git log                          # see where you are in the git tree.

  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; Thank You git bisect has proven to be incredibly interesting.<br>
<br>
&nbsp;&nbsp;&nbsp; One question/problem - maybe an incomplete understanding of git.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; What I need to do is get to some version of 2.6.16 - as they all
work for me.<br>
<br>
&nbsp;&nbsp;&nbsp; cut in my patches.<br>
<br>
&nbsp;&nbsp;&nbsp; And THEN start bisecting while retaining my patches.<br>
<br>
&nbsp;&nbsp;&nbsp; Is that going to work or am I going to have to repatch each time ?<br>
<br>
&nbsp;&nbsp;&nbsp; Basically can I use git to insert a patch into the middle of its
delta history and then advance forward from there ?<br>
<br>
&nbsp;&nbsp;&nbsp; It is rapidly becoming obvious that competence with git could have
big payback.<br>
<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------030004060601000705050503--
