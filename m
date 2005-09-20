Return-Path: <wd@denx.de>
To: "KylongMu" <mqy@263.net.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Sep 2005 23:17:56 +0800."
	<20050920151811.C0246E55@smtp.263.net>
Date: Tue, 20 Sep 2005 20:10:45 +0200
Sender: wd@denx.de
Message-Id: <20050920181045.21320353AB3@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: ELDK included in which AMCC440EP Kit? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050920151811.C0246E55@smtp.263.net> you wrote:
> 
>     I'm going to buy the AMCC440EP Evaluation Kit , there are two
> types : one is Bamboo , another is Yosemite .
>     Witch of them supported by ELDK , or both of them . There are
> not clear message from web.

The ELDK is a tool chain. It is hardware independent, so any  4xx/44x
board is "supported" by the ELDK.

Both the U-Boot and the Linux source code as available  on  the  ELDK
CDROM  image  is  too  old  for  the Yosemite, but you can access the
current versions from our git/CVS/FTP servers, and then  both  Bamboo
and Yosemite are supported.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The more data I punch in this card,  the lighter it becomes, and the
lower the mailing cost."
                     - Stan Kelly-Bootle, "The Devil's DP Dictionary"
