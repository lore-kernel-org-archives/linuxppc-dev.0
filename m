Date: Tue, 4 Mar 2003 13:09:02 -0600
From: Dave Wolfe <dwolfe@lists.linuxppc.org>
To: Ibon Gotxi Garcia <igotxi@jazzfree.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Console
Message-ID: <20030304130902.A22000@lists.linuxppc.org>
References: <000801c2e25d$d560ec10$370da8c0@aman> <3E64C8DD.5010100@mvista.com> <1046797567.379.16.camel@muse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1046797567.379.16.camel@muse>; from igotxi@jazzfree.com on Tue, Mar 04, 2003 at 05:06:07PM +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[ Ibon Gotxi Garcia writes: ]
>
> newbie question:
> is there any chance of having virtual terminals through the serial port?

Check out screen ftp:ftp.uni-erlangen.de/pub/utilities/screen

   Screen is a full-screen window manager that multiplexes a physical ter-
   minal between several processes (typically interactive  shells).  Each
   virtual terminal provides the functions of a DEC VT100 terminal and, in
   addition, several control functions from the ISO 6429  (ECMA  48, ANSI
   X3.64)  and ISO 2022 standards (e.g. insert/delete line and support for
   multiple character sets).  There is a  scrollback  history buffer  for
   each virtual terminal and a copy-and-paste mechanism that allows moving
   text regions between windows.

and much, much more... It's not limited to serial terminals, BTW.

--
 Dave Wolfe

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
