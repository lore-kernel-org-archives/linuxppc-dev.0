To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Calling Application 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Jan 2003 00:24:10 +0530."
             <001b01c2b810$7ec76720$370da8c0@aman>
Date: Thu, 09 Jan 2003 20:10:31 +0100
Message-Id: <20030109191037.06822C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001b01c2b810$7ec76720$370da8c0@aman> you wrote:
>
> This might be a basic question. I have build the linux kernel for custom
> board which has PPC 440GP as its processor. I have also build my
> application. Now I wanted to call my application after the kernel boots up.
> Can you tell me where I hv to call my application.

Just like you start all other utility and server  processes  in  Unix
systems:  either  you start it from one of your init scripts, or - in
case of simple systems - your application might even become the  init
process.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Life sucks, but it's better than the alternative."
- Peter da Silva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
