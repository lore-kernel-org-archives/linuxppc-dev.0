Message-Id: <200010261912.e9QJCNu05106@denx.local.net>
To: Zhaobin Zhu <zzhu@emc.com>
cc: linuxppc-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Convert srecord file to binary file 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Oct 2000 13:23:38 EDT."
             <39F8689A.5BEAA6F2@emc.com>
Date: Thu, 26 Oct 2000 21:12:23 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <39F8689A.5BEAA6F2@emc.com> Zhaobin Zhu wrote:
>
> Is there an utility under linux/unix to convert srecord file to binary file
> which can be burnt into eprom ?

Of course:

	objcopy -I srec -O binary srecord_file binary_file

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When all else fails, read the instructions.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
