Return-Path: <sasvata.chatterjee@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id 69CB9DE033
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 01:29:57 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so1603402nzb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 08:29:55 -0700 (PDT)
Message-ID: <a9fc2a630705290829p66cb6f83m25b16a35404c6613@mail.gmail.com>
Date: Tue, 29 May 2007 10:29:54 -0500
From: "Sasvata Chatterjee" <sasvata.chatterjee@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: Latest GCC/GLIBC working combo for a Linux 2.4.x kernel?
In-Reply-To: <20070525213909.5BC8C353428@atlas.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_191495_21984653.1180452594778"
References: <a9fc2a630705241728q4d203569n6eb008cc65a7eba9@mail.gmail.com>
	<20070525213909.5BC8C353428@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_191495_21984653.1180452594778
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Wolfgang,

Thanks for the pointer, and I am familiar with ELDK, since we are planning
on using it for a brand new embedded system.

On the older system, for which I started this thread, we need to use kernel
2.4.  ELDK-4.1 is based on kernel 2.6.19.  Is there an older ELDK I can get
that supported 2.4.x kernel with > 3.x GCC?

Thanks again!

Shash

PS: I have built gcc-4.1.1-glibc-2.3.6 cross-compiler for powerc-603e, and
working through compilation of kernel-2.4.26, but there are lots of problems
that I am needing to work through.

On 5/25/07, Wolfgang Denk <wd@denx.de> wrote:
>
>
> Did you have a look at the ELDK?
>
>

------=_Part_191495_21984653.1180452594778
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Wolfgang,<br><br>Thanks for the pointer, and I am familiar with ELDK, since we are planning on using it for a brand new embedded system.<br><br>On the older system, for which I started this thread, we need to use kernel 2.4
.&nbsp; ELDK-4.1 is based on kernel 2.6.19.&nbsp; Is there an older ELDK I can get that supported 2.4.x kernel with &gt; 3.x GCC?<br><br>Thanks again!<br><br>Shash<br><br>PS: I have built gcc-4.1.1-glibc-2.3.6 cross-compiler for powerc-603e, and working through compilation of 
kernel-2.4.26, but there are lots of problems that I am needing to work through.<br><br><div><span class="gmail_quote">On 5/25/07, <b class="gmail_sendername">Wolfgang Denk</b> &lt;<a href="mailto:wd@denx.de">wd@denx.de</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Did you have a look at the ELDK?<br><br></blockquote></div><br>

------=_Part_191495_21984653.1180452594778--
