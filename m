To: "Kapil Konde" <kapilkk@yahoo.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Bad Magic Number 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Oct 2001 14:39:47 +0530."
             <GDEHIPAFEMJDKNFDCIEBIEGECCAA.kapilkk@yahoo.com>
Date: Fri, 05 Oct 2001 09:10:56 +0200
Message-Id: <20011005071101.41BA8100A5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <GDEHIPAFEMJDKNFDCIEBIEGECCAA.kapilkk@yahoo.com> you wrote:
>
> 	I am trying to boot linux on my custom mpc8xx card. I have ppcboot loaded
> and I am loading linux kernel image using tftp. When I say bootm it gives me
> error "Bad Magic Number".
> Can anybody please explain the error and suggest any solution for it.

The image you are trying to boot is not a PPCBoot image, i. e. it was
not created using the "mkimage" tool that omes with PPCBoot. See  the
PPCBoot README file.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Conscious is when you are aware of something, and conscience is  when
you wish you weren't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
