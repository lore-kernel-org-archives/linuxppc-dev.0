Return-Path: <tieuphongit@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id 3260BDDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 13:04:05 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so274067wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 18:04:04 -0800 (PST)
Message-ID: <f2042b870701101804o65db510ct146eab5892e1db1d@mail.gmail.com>
Date: Thu, 11 Jan 2007 09:04:04 +0700
From: "An Le Thien" <tieuphongit@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: Can't start snmpd when adding notification handler to the
	configuration file
In-Reply-To: <20070111011937.C0C9A35264F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17563_10762752.1168481044757"
References: <f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com>
	<20070111011937.C0C9A35264F@atlas.denx.de>
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

------=_Part_17563_10762752.1168481044757
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried to download
net-snmp-5.2.1.2-1_1.src.rpm<ftp://ftp.sunet.se/pub/Linux/distributions/eldk/4.0/ppc-linux-x86/sources/target/SRPMS/net-snmp-5.2.1.2-1_1.src.rpm>of
ELDK4.0 and  used ELDK4.0  to build. But the same error happens :(. Then I
tried to build net-snmp-5.0.6-17_2.src.rpm with ELDK4.0. The error still
happens.

Best Regards,
An Le.

On 1/11/07, Wolfgang Denk <wd@denx.de> wrote:
>
> In message <f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com>
> you wrote:
> >
> > 2. I used ELDK3.1.1 to build it and install to ramdisk that is used for
> > TQM8xxL (Using kernel 2.6.11)
>
> ELDK 3.x has been tested with  2.4  kernel  trees  only.  For  a  2.6
> kernel, you should use ELDK 4.x.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Hiring experienced unix people is  like  a  built-in  filter  against
> idiots. Hiring experienced NT people provides no such guarantee.
>             -- Miguel Cruz in WgL96.349$CC.122704@typhoon2.ba-dsg.net
>

------=_Part_17563_10762752.1168481044757
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried to download <a href="ftp://ftp.sunet.se/pub/Linux/distributions/eldk/4.0/ppc-linux-x86/sources/target/SRPMS/net-snmp-5.2.1.2-1_1.src.rpm">net-snmp-5.2.1.2-1_1.src.rpm</a> of ELDK4.0 and&nbsp; used ELDK4.0&nbsp; to build. But the same error happens :(. Then I tried to build 
net-snmp-5.0.6-17_2.src.rpm with ELDK4.0. The error still happens.<br><br>Best Regards,<br>An Le.<br><br><div><span class="gmail_quote">On 1/11/07, <b class="gmail_sendername">Wolfgang Denk</b> &lt;<a href="mailto:wd@denx.de">
wd@denx.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">In message &lt;<a href="mailto:f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com">
f2042b870701100733v20d7a052kca11f2ef0d108849@mail.gmail.com</a>&gt; you wrote:<br>&gt;<br>&gt; 2. I used ELDK3.1.1 to build it and install to ramdisk that is used for<br>&gt; TQM8xxL (Using kernel 2.6.11)<br><br>ELDK 3.x has been tested with&nbsp;&nbsp;
2.4&nbsp;&nbsp;kernel&nbsp;&nbsp;trees&nbsp;&nbsp;only.&nbsp;&nbsp;For&nbsp;&nbsp;a&nbsp;&nbsp;2.6<br>kernel, you should use ELDK 4.x.<br><br>Best regards,<br><br>Wolfgang Denk<br><br>--<br>Software Engineering:&nbsp;&nbsp;Embedded and Realtime Systems,&nbsp;&nbsp;Embedded Linux<br>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: 
<a href="mailto:wd@denx.de">wd@denx.de</a><br>Hiring experienced unix people is&nbsp;&nbsp;like&nbsp;&nbsp;a&nbsp;&nbsp;built-in&nbsp;&nbsp;filter&nbsp;&nbsp;against<br>idiots. Hiring experienced NT people provides no such guarantee.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-- Miguel Cruz in <a href="mailto:WgL96.349$CC.122704@typhoon2.ba-dsg.net">
WgL96.349$CC.122704@typhoon2.ba-dsg.net</a><br></blockquote></div><br>

------=_Part_17563_10762752.1168481044757--
