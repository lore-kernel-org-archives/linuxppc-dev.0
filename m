To: "yydsr" <yydsr@163.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: =?gb2312?B?QWJvdXQgSUJNICBXYWxudXQ0MDVHUCAgUHJvYmxlbS4=?= 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Dec 2002 09:59:35 +0800."
             <3E0BB407.000043.10611@bj244.163.com>
Date: Fri, 27 Dec 2002 09:57:28 +0100
Message-Id: <20021227085733.0E0BBC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E0BB407.000043.10611@bj244.163.com> you wrote:
>
>     I'm trying to get a walnut board booted. I'm using linuxppc_2_4_devel pulled from denx yesterday. I'm getting the "Real time clock seems stuck" message then nothing, no messages after that. I found a brief thread about this.
...
> Any ideas? I've searched the archives for walnut boot problems. It seems like most people just get it running and that's that.

Since you are using PPCBoot and a linuxppc_2_4_devel kernel - did you
check that "clocks_in_mhz" is _not_ set in your PPCBoot environment?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Memories of you remind me of you.                   - Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
