To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK missing ip program ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 12 Apr 2003 14:27:03 +0200."
             <3E980617.1040603@dgt-lab.com.pl>
Date: Sat, 12 Apr 2003 15:17:38 +0200
Message-Id: <20030412131743.5E4B1C5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E980617.1040603@dgt-lab.com.pl> you wrote:
>
> where is /sbin/ip program ? it's needet to iup script

The iproute package is not (yet) included with the ELDK.
Please use ifconfig manually.

And of course: feel free to contribute a new package to the ELDK.
It's an Open Source project.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"In the face of entropy and nothingness, you kind of have to  pretend
it's  not  there  if  you  want  to  keep writing good code."
- Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
