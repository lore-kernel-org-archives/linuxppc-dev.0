Return-Path: <netstv@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.182])
	by ozlabs.org (Postfix) with ESMTP id 2541ADDECC
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 02:20:56 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so627898ika
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Mar 2007 09:20:54 -0700 (PDT)
Message-ID: <b4b98b690703310920k63a60835s8d3ba6993d72179d@mail.gmail.com>
Date: Sat, 31 Mar 2007 09:20:52 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Charles Krinke" <ckrinke@istor.com>
Subject: Re: PPC login puzzle
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6C@MERCURY.inside.istor.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_89731_4371503.1175358052864"
References: <20070329192932.98FBD353A6C@atlas.denx.de>
	<200703291345.35978.tmaenner@aehr.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com>
	<460DDB1F.7020106@billgatliff.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6C@MERCURY.inside.istor.com>
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

------=_Part_89731_4371503.1175358052864
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<snip...>
>
>
> Yes, that that is another part of the puzzle as both the /etc/securetty
> and the /etc/xinetd.d/telnet files are identical in both root filesystems.
> So, there must be some ither file somewhere keeping me from cooking my toast
> with a telnet login to the 8541.



Seems to me thing you can do is find out why the telnet session is being
rejected.  Have you done an ethernet capture?

Do you have any firewalling setup?  In that case you need to make sure your
rules are setup properly.  The ethernet capture should give you a clue.

Are you sure the telnetd can be found on your system that doesn't work?
What do the logs tell you on the machine that doesn't work?  I think xinetd
kicks out a log file, what does that tell you?

Have you tried on the 8541,  login to the terminal and then telnet to
localhost?  If you can do that, then I'd say it's a firewalling problem, if
not, then it's a telnetd type of problem.


Hope that helps.

-stv

-- 
/*
* Steve Iribarne
* Software Engineer
* (aka Grunt)
*/

------=_Part_89731_4371503.1175358052864
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&lt;snip...&gt;<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Yes, that that is another part of the puzzle as both the /etc/securetty and the /etc/xinetd.d/telnet files are identical in both root filesystems. So, there must be some ither file somewhere keeping me from cooking my toast with a telnet login to the 8541.
</blockquote><div><br><br>Seems to me thing you can do is find out why the telnet session is being rejected.&nbsp; Have you done an ethernet capture? <br><br>Do you have any firewalling setup?&nbsp; In that case you need to make sure your rules are setup properly.&nbsp; The ethernet capture should give you a clue.
<br><br>Are you sure the telnetd can be found on your system that doesn&#39;t work?&nbsp; What do the logs tell you on the machine that doesn&#39;t work?&nbsp; I think xinetd kicks out a log file, what does that tell you?<br><br>Have you tried on the 8541,&nbsp; login to the terminal and then telnet to localhost?&nbsp; If you can do that, then I&#39;d say it&#39;s a firewalling problem, if not, then it&#39;s a telnetd type of problem.&nbsp; 
<br><br><br>Hope that helps.<br><br>-stv<br></div></div><br>-- <br>/*<br> * Steve Iribarne<br> * Software Engineer<br> * (aka Grunt) <br> */

------=_Part_89731_4371503.1175358052864--
