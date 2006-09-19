Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) by ozlabs.org (Postfix) with ESMTP id 94C2D67B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 06:56:07 +1000 (EST)
Message-ID: <451055D2.5080308@dlasys.net>
Date: Tue, 19 Sep 2006 16:40:50 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
	<528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	<87hcz4z47p.fsf@sleipner.barco.com>
	<528646bc0609190717u1c7cd349m7e08e5bafd341c38@mail.gmail.com>
	<528646bc0609191310l240d9f94tb18415941f8b5d4f@mail.gmail.com>
In-Reply-To: <528646bc0609191310l240d9f94tb18415941f8b5d4f@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------020407000204060805080808"
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
--------------020407000204060805080808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Likely wrote:
>
>
> Avast!  After getting quizzed on IRC about this off-the-cuff comment,
> I should probably clarify.  Since the Xilinx IP could be wired up to a
> ublaze core or an off-chip processor, the drivers still need to use a
> platform bus attachment to keep it all cross platform.
>
> So, replace above comment with the following:
>
> Populating the platform device with static code during initialization
> is sooo last year.
>
> Time to hack device trees to populate it instead.
>   
    So I got another X V4 board. I hacked in the Platform device stuff 
from you ml403 code with changes needed for my hardware.
    and my brain is slowly begining to actually grasp  what is going on 
- I am begining to grasp the platform devices big picture (over a 
mountain through a spyglass in the fog)

    Where do I begin with Device Trees ?

    The vague Picture I have is the have something to do with some 
datastructure that Mac's typically create at or prior to boot. And that 
for embedded systems we are building them
    externally compiling them and then attaching the compiled device 
tree to our project.

    I got a Xilinv V4 device currently with a Pic, UartLite, TEMAC, 
Flash and Keyhole (pseuodo serial host interface). Of those it is only 
certain that the flash will always be there.
    We have bit images with Keyhole only, Uartlite only TEMAC only, 
Sometimes we have a Pic sometimes not. I was trying to get to the point 
were I could dynamically add what was there
    to Platform devices during initialization.

    If Device trees are static, then do they even apply to what I have 
to deal with ?

    Please pardon my ignorance.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------020407000204060805080808
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
 cite="mid528646bc0609191310l240d9f94tb18415941f8b5d4f@mail.gmail.com"
 type="cite"><br>
  <pre wrap=""><!---->
Avast!  After getting quizzed on IRC about this off-the-cuff comment,
I should probably clarify.  Since the Xilinx IP could be wired up to a
ublaze core or an off-chip processor, the drivers still need to use a
platform bus attachment to keep it all cross platform.

So, replace above comment with the following:

Populating the platform device with static code during initialization
is sooo last year.

Time to hack device trees to populate it instead.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; So I got another X V4 board. I hacked in the Platform device stuff
from you ml403 code with changes needed for my hardware.<br>
&nbsp;&nbsp;&nbsp; and my brain is slowly begining to actually grasp&nbsp; what is going on
- I am begining to grasp the platform devices big picture (over a
mountain through a spyglass in the fog)<br>
<br>
&nbsp;&nbsp;&nbsp; Where do I begin with Device Trees ?<br>
<br>
&nbsp;&nbsp;&nbsp; The vague Picture I have is the have something to do with some
datastructure that Mac's typically create at or prior to boot. And that
for embedded systems we are building them<br>
&nbsp;&nbsp;&nbsp; externally compiling them and then attaching the compiled device
tree to our project.<br>
<br>
&nbsp;&nbsp;&nbsp; I got a Xilinv V4 device currently with a Pic, UartLite, TEMAC,
Flash and Keyhole (pseuodo serial host interface). Of those it is only
certain that the flash will always be there.<br>
&nbsp;&nbsp;&nbsp; We have bit images with Keyhole only, Uartlite only TEMAC only,
Sometimes we have a Pic sometimes not. I was trying to get to the point
were I could dynamically add what was there <br>
&nbsp;&nbsp;&nbsp; to Platform devices during initialization.<br>
<br>
&nbsp;&nbsp;&nbsp; If Device trees are static, then do they even apply to what I have
to deal with ?<br>
<br>
&nbsp;&nbsp;&nbsp; Please pardon my ignorance.<br>
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

--------------020407000204060805080808--
