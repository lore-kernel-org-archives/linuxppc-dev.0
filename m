To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: large file support? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Jul 2003 14:01:10 +0200."
             <3F290506.3060304@imc-berlin.de>
Date: Thu, 31 Jul 2003 14:50:08 +0200
Message-Id: <20030731125013.64881C602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F290506.3060304@imc-berlin.de> you wrote:
>
> I reckon my app does not support large files. Since after writing 2GB
> to a file

Did  you  build  it  with  the  required  options,   like   #defining
_FILE_OFFSET_BITS as 64 ?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You are only young once, but you can stay immature indefinitely.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
