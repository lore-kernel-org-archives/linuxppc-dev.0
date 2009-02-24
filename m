Return-Path: <mbergandi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id ABE6ADDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 11:11:53 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so682902qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 16:11:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
Date: Mon, 23 Feb 2009 19:11:51 -0500
Message-ID: <1c641bc80902231611j57d53abcx56b32439f26cdf8@mail.gmail.com>
Subject: Re: soc vs localbus for flash in device tree
From: Michael Bergandi <mbergandi@gmail.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Content-Type: multipart/alternative; boundary=0015175ca9524639ed04639ef70a
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175ca9524639ed04639ef70a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>
>
> I'm working on the kernel version Linux-2.6.29-rc5 with U-Boot
> 1.2.0-g88e21e7b-dirty.


I recommend you use a more current version of U-Boot. That one is quite old.


Does the flash node HAVE to be within a localbus node or can it reside
> within the soc node? I've been basing my work on mpc834x_mds.dts
> And hence haven't defined a localbus node.


I think it can be in either, but the most common place I've seen is in the
soc node.


> BTW is there a way to search the ML archive? Currently I browse each month
> to search for prior postings.


Yes, Google "site:ozlabs.org <what ever you are looking for>"

Mike

--0015175ca9524639ed04639ef70a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;"><br>
I&#39;m working on the kernel version Linux-2.6.29-rc5 with U-Boot 1.2.0-g8=
8e21e7b-dirty.</blockquote><div><br>I recommend you use a more current vers=
ion of U-Boot. That one is quite old. <br><br></div><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">

Does the flash node HAVE to be within a localbus node or can it reside with=
in the soc node? I&#39;ve been basing my work on mpc834x_mds.dts<br>
And hence haven&#39;t defined a localbus node.</blockquote><div><br>I think=
 it can be in either, but the most common place I&#39;ve seen is in the soc=
 node.<br>&nbsp;<br></div><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">

BTW is there a way to search the ML archive? Currently I browse each month =
to search for prior postings.</blockquote><div><br>Yes, Google &quot;site:<=
a href=3D"http://ozlabs.org">ozlabs.org</a> &lt;what ever you are looking f=
or&gt;&quot;<br>
<br>Mike<br></div></div><br>

--0015175ca9524639ed04639ef70a--
