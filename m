To: Rakesh Jagota <j.rakesh@gdatech.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JFFS2 for IBM ppc405 based Target board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 21 Apr 2003 10:24:12 +0530."
             <slemye5aoor48df.210420031014@gda-server>
Date: Mon, 21 Apr 2003 09:50:34 +0200
Message-Id: <20030421075039.98028C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <slemye5aoor48df.210420031014@gda-server> you wrote:
>
> I am using montavista linux priviewkit 2.4.17. Currently I am using nfs. How
> can I create jffs2 file fyftem. I am working with IBM power pc 405. Can
> anyone suggest me, how to create the jffs2 filesystem for PPC 405.

Create a directory  with  all  the  required  files  for  yout  JFFS2
filesystem,  and use the mkfs.jffs2 which comes with the MTD tools to
create a JFFS2 image.

See also the mkfs.jffs2 man page.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Engineering without management is art."               - Jeff Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
