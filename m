To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: jffs2 partition on a TQM860L??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Jun 2003 18:55:53 +0200."
             <3EDB8199.8090805@imc-berlin.de>
Date: Mon, 02 Jun 2003 21:56:50 +0200
Message-Id: <20030602195655.BF2AEC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EDB8199.8090805@imc-berlin.de> you wrote:
>
> I want to use JFFS2 as root fs on a TQM860L with 8MB flash.
> This flash is seperated into two flash banks each 4MB.
>
> (How) can I define one big jffs2 partition (in
> ./drivers/mtd/maps/tqm8xxl.c) that contains sectors from both flash banks?

Just use a more recent version  of  the  MTD  code,  for  example  as
contained  in our linuxppc_2_4_devel tree. It will automagically join
adjacent flash banks into one MTD device.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"An open mind has but one disadvantage: it collects dirt."
                                                    - a saying at RPI

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
