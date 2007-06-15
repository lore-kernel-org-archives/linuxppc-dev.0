Return-Path: <blofeldus@yahoo.com>
Received: from web53504.mail.re2.yahoo.com (web53504.mail.re2.yahoo.com
	[206.190.37.65]) by ozlabs.org (Postfix) with SMTP id 64B11DDF32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jun 2007 02:20:33 +1000 (EST)
Date: Fri, 15 Jun 2007 09:13:52 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: Status of MPC5200B FEC driver ?
To: Daniel Schnell <daniel.schnell@marel.com>, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <549718.63629.qm@web53504.mail.re2.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel,
 Maybe using Sylvain's patches from 2007-05-13 http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035953.html will help?

 Does anyone know if those patches are ready for Paul Mackerras' "for-2.6.23" branch? http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037903.html

-roger

---- Original Message ----
From: Daniel Schnell <daniel.schnell@marel.com>
To: Daniel Schnell <daniel.schnell@marel.com>; linuxppc-embedded@ozlabs.org
Sent: Thursday, June 14, 2007 12:13:24 PM
Subject: RE: Status of MPC5200B FEC driver ?

Hmm,

If I initiate first a ping from within U-Boot and then boot Linux via IDE, the FEC works.

Seems that some initialization is missing inside the Linux MPC5200 FEC driver ?


Best regards,

Daniel.







      ____________________________________________________________________________________
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us. http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 
