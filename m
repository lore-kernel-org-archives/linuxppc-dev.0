Message-ID: <29624.216.110.51.8.1071881030.squirrel@www.orkun.us>
In-Reply-To: <27309.216.110.51.8.1071865134.squirrel@www.orkun.us>
References: <27309.216.110.51.8.1071865134.squirrel@www.orkun.us>
Date: Fri, 19 Dec 2003 18:43:50 -0600 (CST)
Subject: Re: Free ppc linux configuation tool?
From: "listmember@orkun.us" <listmember@orkun.us>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am creating a linux .config file for an embedded PowerPC 405gp board.
>
> Is there a menu driven free tool (console or X11 based) to assist me?

OK. Problem solved. I had forgotton to set ARCH=ppc in the main makefile
:( This is very important step I missed because I am doing cross
development and native ARCH defaulted to i386. Thanks for everyone that
has responded.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
