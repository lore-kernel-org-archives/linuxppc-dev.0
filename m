To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ramdisk Question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 25 Jan 2002 14:22:11 +0900."
             <007b01c1a560$3e368b50$1a11efcb@industrialDiv.hanasys.co.kr>
Date: Fri, 25 Jan 2002 10:00:20 +0100
Message-Id: <20020125090025.CF263102DA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <007b01c1a560$3e368b50$1a11efcb@industrialDiv.hanasys.co.kr> you wrote:
>
> I am porting linux on a custom mpc755 board.
> I used linuxppc_2_4 from montavista rsync,
> and simple-ramdisk.tar.gz from denx ftp.

This ramdisk image was build for MPC8xx systems; I never tested it on
a 75x. It probably does not work there.

You better rebuild your own image with binaries  and  librarioes  for
the 75x; let me know if you have problems.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The inappropriate cannot be beautiful.
             - Frank Lloyd Wright _The Future of Architecture_ (1953)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
